using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCore_Autorepair.Models
{
    public class Car
    {
        public int CarId { get; set; }
        public string Brand { get; set; }
        public int Power { get; set; }
        public string Color { get; set; }
        public string StateNumber { get; set; }
        public int OwnerId { get; set; }
        public Owner Owner { get; set; }
        public int Year { get; set; }
        public string VIN { get; set; }
        public string EngineNumber { get; set; }
        public DateTime AdmissionDate { get; set; }
        public ICollection<Payment> PaymentsLists { get; set; }

        public override string ToString()
        {
            return "CarId: " + CarId + " | Brand: " + Brand + " | Power: " + Power + " | Color: " + Color +
               " | StateNumber: " + StateNumber + " | OwnerId: " + OwnerId + " | Year: " + Year + " | VIN: " + VIN +
               " | EngineNumber: " + EngineNumber + " | AdmissionDate: " + AdmissionDate.ToShortDateString();
        }

    }
}
