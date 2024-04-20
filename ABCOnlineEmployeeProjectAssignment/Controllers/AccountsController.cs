using ABCOnlineEmployeeProjectAssignment.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI.WebControls;

namespace ABCOnlineEmployeeProjectAssignment.Controllers
{
    public class AccountsController : Controller
    {
        // GET: Accounts
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        // POST: Accounts/Login
        [HttpPost]
        public ActionResult Login(UserModel model)
        {
            using (ABCProjectManagementEntities context = new ABCProjectManagementEntities())
            {
                bool isValidUser = context.Users.Any(login => login.Email.ToLower() ==
                model.Email.ToLower() && login.Password == model.Password);
                if (isValidUser)
                {
                    FormsAuthentication.SetAuthCookie(model.Email, false);

                    var employee = (from e in context.Employees
                                join u in context.Users
                                on e.EmployeeNumber equals u.UserId
                                where u.Email == model.Email
                                select e).FirstOrDefault();
                    if (employee != null)
                    {
                        switch (employee.Role)
                        {
                            case "IT Project Manager":
                                return RedirectToAction("Index", "ProjectAssignments");
                            case "Programmer":
                                FormsAuthentication.SignOut();
                                ModelState.AddModelError("", "Access denied!");
                                return View();
                            default:
                                return RedirectToAction("Login", "Accounts");
                        }
                    }

                }
                ModelState.AddModelError("", "Invalid username or password !");
                return View();
            }
        }

        // GET: Accounts/Signup
        public ActionResult Signup()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Signup(UserModel signup)
        {
            if (ModelState.IsValid)
            {
                using (ABCProjectManagementEntities context = new ABCProjectManagementEntities())
                {
                    // Create User instances
                    var login = new User
                    {
                        Email = signup.Email,
                        Password = signup.Password
                    };
                    // Create instances for Employee
                    var user = new Employee
                    {
                        FirstName = signup.FirstName,
                        LastName = signup.LastName,
                        Role = "IT Project Manager" // Hard-coded for this iteration
                    };


                    // Add User and Employee
                    context.Employees.Add(user);
                    context.Users.Add(login);
                    

                    // Save changes to the database
                    context.SaveChanges();

                    return RedirectToAction("Login");
                }
            }

            // If ModelState is not valid, return to the signup view with validation errors.
            return View(signup);
        }

        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Login");
        }
    }
}