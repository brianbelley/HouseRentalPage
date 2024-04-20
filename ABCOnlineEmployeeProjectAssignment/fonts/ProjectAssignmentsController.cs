using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.WebPages;
using ABCOnlineEmployeeProjectAssignment.Models;

namespace ABCOnlineEmployeeProjectAssignment.Controllers
{
    [Authorize]
    public class ProjectAssignmentsController : Controller
    {
        private ABCProjectManagementEntities db = new ABCProjectManagementEntities();

        // GET: ProjectAssignments
        public ActionResult Index(string ProjectCode, string EmployeeNumber)
        {
            if (ProjectCode.IsEmpty() && EmployeeNumber.IsEmpty()) // Initial view
            {
                var projectAssignments = db.ProjectAssignments.Include(p => p.Employee).Include(p => p.Project).ToList();
                ViewBag.EmployeeNumber = db.Employees.Where(u => u.Role == "Programmer").Select(u => new SelectListItem { Value = u.EmployeeNumber.ToString(), Text = u.FirstName + " " + u.LastName + ", " + u.EmployeeNumber }).ToList();
                ViewBag.ProjectCode = db.Projects.Select(p => new SelectListItem { Value = p.ProjectCode.ToString(), Text = p.ProjectTitle }).ToList();
                return View(projectAssignments);
            } else
            {
                if (!ProjectCode.IsEmpty()) // Filter by project code
                {
                    var projectAssignments = db.ProjectAssignments.Include(p => p.Project).Include(p => p.Employee).Where(p => p.ProjectCode == ProjectCode).ToList();
                    ViewBag.EmployeeNumber = db.Employees.Where(u => u.Role == "Programmer").Select(u => new SelectListItem { Value = u.EmployeeNumber.ToString(), Text = u.FirstName + " " + u.LastName + ", " + u.EmployeeNumber }).ToList();
                    ViewBag.ProjectCode = db.Projects.Select(p => new SelectListItem { Value = p.ProjectCode.ToString(), Text = p.ProjectTitle }).ToList();
                    ViewBag.ResultsTitle = "List of Employees assigned to Project " + ProjectCode;
                    return View(projectAssignments);
                } else // Filter by employee
                {
                    int employeeNumber = Convert.ToInt32(EmployeeNumber);
                    ViewBag.EmployeeNumber = db.Employees.Where(u => u.Role == "Programmer").Select(u => new SelectListItem { Value = u.EmployeeNumber.ToString(), Text = u.FirstName + " " + u.LastName + ", " + u.EmployeeNumber }).ToList();
                    ViewBag.ProjectCode = db.Projects.Select(p => new SelectListItem { Value = p.ProjectCode.ToString(), Text = p.ProjectTitle }).ToList();
                    ViewBag.ResultsTitle = "List of Projects assigned to Employee " + EmployeeNumber;
                    var projectAssignments = db.ProjectAssignments.Include(p => p.Project).Include(p => p.Employee).Where(p => p.Employee.EmployeeNumber == employeeNumber);

                    return View(projectAssignments);
                }
            }
           
        }

        // GET: ProjectAssignments/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);
            if (projectAssignment == null)
            {
                return HttpNotFound();
            }
            return View(projectAssignment);
        }

        // GET: ProjectAssignments/Create
        public ActionResult Create()
        {
            ViewBag.EmployeeNumber = db.Employees.Where(e => e.Role == "Employee").Select(e => new SelectListItem { Value = e.EmployeeNumber.ToString(), Text = e.FirstName + " " + e.LastName + ", " + e.EmployeeNumber }).ToList();
            ViewBag.ProjectCode = new SelectList(db.Projects, "ProjectCode", "ProjectTitle");
            return View();
        }

        // POST: ProjectAssignments/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProjectAssignmentId,EmployeeNumber,ProjectCode,AssignedDate,SubmittedDate")] ProjectAssignment projectAssignment)
        {
            if (ModelState.IsValid)
            {
                // verify if project has been assigned to employee
                var projectAssignmentExists = db.ProjectAssignments.Where(p => p.EmployeeNumber == projectAssignment.EmployeeNumber && p.ProjectCode == projectAssignment.ProjectCode).FirstOrDefault();
                if (projectAssignmentExists != null)
                {
                    ModelState.AddModelError("", "Project already assigned to employee.");
                    ViewBag.EmployeeNumber = db.Employees.Where(e => e.Role == "Programmer").Select(e => new SelectListItem { Value = e.EmployeeNumber.ToString(), Text = e.FirstName + " " + e.LastName + ", " + e.EmployeeNumber }).ToList();
                    ViewBag.ProjectCode = new SelectList(db.Projects, "ProjectCode", "ProjectTitle", projectAssignment.ProjectCode);
                    return View(projectAssignment);
                }

                // verify if employee has been assigned 2 projects
                var projectAssignments = db.ProjectAssignments.Where(p => p.EmployeeNumber == projectAssignment.EmployeeNumber).ToList();
                if (projectAssignments.Count == 2)
                {
                    ModelState.AddModelError("", "This employee has been assigned 2 projects.");
                    ViewBag.EmployeeNumber = db.Employees.Where(e => e.Role == "Programmer").Select(e => new SelectListItem { Value = e.EmployeeNumber.ToString(), Text = e.FirstName + " " + e.LastName + ", " + e.EmployeeNumber }).ToList();
                    ViewBag.ProjectCode = new SelectList(db.Projects, "ProjectCode", "ProjectTitle", projectAssignment.ProjectCode);
                    return View(projectAssignment);
                }
                db.ProjectAssignments.Add(projectAssignment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EmployeeNumber = new SelectList(db.Employees, "EmployeeNumber", "FirstName", projectAssignment.EmployeeNumber);
            ViewBag.ProjectCode = new SelectList(db.Projects, "ProjectCode", "ProjectTitle", projectAssignment.ProjectCode);
            return View(projectAssignment);
        }

        // GET: ProjectAssignments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);
            if (projectAssignment == null)
            {
                return HttpNotFound();
            }
            ViewBag.EmployeeNumber = db.Employees.Where(e => e.Role == "Employee").Select(e => new SelectListItem { 
                Value = e.EmployeeNumber.ToString(), 
                Text = e.FirstName + " " + e.LastName + ", " + e.EmployeeNumber, 
                Selected = projectAssignment.EmployeeNumber == e.EmployeeNumber }
            ).ToList();
            ViewBag.ProjectCode = new SelectList(db.Projects, "ProjectCode", "ProjectTitle", projectAssignment.ProjectCode);
            return View(projectAssignment);
        }

        // POST: ProjectAssignments/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProjectAssignmentId,EmployeeNumber,ProjectCode,AssignedDate,SubmittedDate")] ProjectAssignment projectAssignment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(projectAssignment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EmployeeNumber = db.Employees.Where(e => e.Role == "Employee").Select(e => new SelectListItem
                {
                    Value = e.EmployeeNumber.ToString(),
                    Text = e.FirstName + " " + e.LastName + ", " + e.EmployeeNumber,
                    Selected = projectAssignment.EmployeeNumber == e.EmployeeNumber
                }
            ).ToList();
            ViewBag.ProjectCode = new SelectList(db.Projects, "ProjectCode", "ProjectTitle", projectAssignment.ProjectCode);
            return View(projectAssignment);
        }

        // GET: ProjectAssignments/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);
            if (projectAssignment == null)
            {
                return HttpNotFound();
            }
            return View(projectAssignment);
        }

        // POST: ProjectAssignments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            ProjectAssignment projectAssignment = db.ProjectAssignments.Find(id);
            db.ProjectAssignments.Remove(projectAssignment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
