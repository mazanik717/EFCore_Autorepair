using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Net;
using System.Numerics;

namespace EFCore_Autorepair.Models
{
    public class Mechanic
    {
        public int MechanicId { get; set; }
        public string FirstName { get; set; }
        public string MiddleName { get; set; }
        public string LastName { get; set; }
        public Qualification Qualification { get; set; }
        public int QualificationId { get; set; }
        public int Experience { get; set; }
        public ICollection<Payment> PaymentsLists { get; set; }

        public override string ToString()
        {
            return MechanicId + " " + FirstName + " " + MiddleName + " " + LastName + " " + QualificationId + " " + Experience;
        }

    }
}
