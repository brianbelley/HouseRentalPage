using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace ABCOnlineEmployeeProjectAssignment.Models
{
    public class UserModel
    {
        public int UserId { get; set; }
        [Required(ErrorMessage = "Email is required"), EmailAddress(ErrorMessage = "Invalid Email Address"), MaxLength(50)]
        public string Email { get; set; }
        [Required(ErrorMessage = "Password is required"), MaxLength(50)]
        public string Password { get; set; }
        [Required(ErrorMessage = "First Name is required"), MaxLength(50)]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Last Name is required"), MaxLength(50)]
        public string LastName { get; set; }
        public string Role { get; set; }
    }
}