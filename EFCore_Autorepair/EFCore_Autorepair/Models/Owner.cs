using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCore_Autorepair.Models
{
    public class Owner
    {
        public int OwnerId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public int DriverLicenseNumber { get; set; }
        public string Address { get; set; }
        public Int64 Phone { get; set; }
        public ICollection<Car> CarsLists { get; set; }

        public override string ToString()
        {
            return OwnerId + " " + FirstName + " " + MiddleName + " " + LastName + " " + DriverLicenseNumber + " " + Address + " " + Phone;
        }

    }
}
