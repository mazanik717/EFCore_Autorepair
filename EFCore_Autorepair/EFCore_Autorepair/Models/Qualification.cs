using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EFCore_Autorepair.Models
{
    public class Qualification
    {
        public int QualificationId { get; set; }
        public string Name { get; set; }
        public int Salary { get; set; }
        public ICollection<Mechanic> MechanicsLists { get; set; }

        public override string ToString()
        {
            return QualificationId + " " + Name + " " + Salary; 
        }
    }
}
