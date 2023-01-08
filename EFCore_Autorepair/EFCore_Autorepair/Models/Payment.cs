using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace EFCore_Autorepair.Models
{
    public class Payment
    {
        public int PaymentId { get; set; }
        public Car Car { get; set; }
        public int CarId { get; set; }
        public DateTime Date { get; set; }
        public int Cost { get; set; }
        public Mechanic Mechanic { get; set; }
        public int MechanicId { get; set; }
        public string ProgressReport { get; set; }

        public override string ToString()
        {
            return PaymentId + " " + CarId + " " + Date + " " + Cost + " " + MechanicId + " " + ProgressReport;
        }
    }
}
