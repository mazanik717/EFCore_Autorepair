using EFCore_Autorepair.Data;
using EFCore_Autorepair.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Runtime.Intrinsics.X86;
using System.Threading.Tasks;

namespace EFCore_Autorepair
{
    public class Program
    {
        public static void Main(string[] args)
        {
            using (AutorepairContext context = new AutorepairContext())
            {
                //SelectFromOwner(context, 20); // 1. Выбор N владельцев

                //SelectFromCarsByPowerAndYear(context, 500, 2010); // 2. Выборка по нескольким полям (Выбор авто по мощности и году)
                //SelectFromCarsByOwnerId(context, 10); // 2. Выборка по одному полю. (Автомобили заданного владельца)

                //SelectGroupByYearCars(context); // 3. Выборка по group by (Вывод кол-во автомобилей для каждого года)

                //SelectMechanicAndQualification(context, 50); // 4. Выборку данных из 2 таблиц, «один - ко - многим» (Вывод механиков и название их квалификаций)
                
                
                //SelectMechanicAndQualificationByQualifNameAndExperience(context, 3, 10, 50); // 5. Выборку данных из 2 таблиц, «один - ко - многим» и отфильтрованным
                                                                                             // по некоторому условию, налагающему ограничения на значения нескольких полей
                                                                                             // (Вывод механиков с заданной квалификацией и больше чем заданный стаж работы)
                
                //Insert(context); // 6.Вставку данных в таблицы, стоящей на стороне отношения «Один» – 1 шт.
                                 // 7.Вставку данных в таблицы, стоящей на стороне отношения «Многие» – 1 шт.
                                 // (Вставка в таблицу квалификация(«Один») и вставка в таблицу механики(«Многие»))

                // 8.Удаление данных из таблицы, стоящей на стороне отношения «Один» – 1 шт.
                // 9.Удаление данных из таблицы, стоящей на стороне отношения «Многие» – 1 шт.
                //DeleteByMechanic(context, "Ivan", "Ivanov", "Ivanovich"); // Удаление заданного механика(по ФИО)
                //DeleteByQualificationAndMechanicWithQualification(context, "6 разряд"); // Удаление квалификации и(каскадно) всех механиков с заданной квалификацией
                
                // 10.Обновление удовлетворяющих определенному условию записей в любой из таблиц базы данных – 1 шт.
                // Изменение мощности всем автомобилям владельца.
                UpdatePowerCarById(context, 10, 410);
            }

            // 1.Выборку всех данных из таблицы, стоящей в схеме базы данных нас стороне отношения «один» – 1 шт.

            // Выбор первых N владельцев
            static void SelectFromOwner(AutorepairContext context, int recordsNum)
            {
                var queryLINQ = context.Owners;


               foreach (Owner own in queryLINQ.Take(recordsNum).ToList())
               {
                    Console.WriteLine(own.ToString());
                }
               
            }
            // 2.Выборку данных из таблицы, стоящей в схеме базы данных нас стороне отношения «один»,
            // отфильтрованные по определенному условию, налагающему ограничения на одно или несколько полей – 1 шт.

            // Выбор авто по одному полю(автомобили заданного владельца владельца)
            static void SelectFromCarsByOwnerId(AutorepairContext context, int ownerId)
            {
                var queryLINQ = context.Cars.Where(c => c.OwnerId.Equals(ownerId));
                foreach (var c in queryLINQ)
                {
                    Console.WriteLine(c.ToString());
                }
            }

            // Выбор авто по мощности и году
            static void SelectFromCarsByPowerAndYear(AutorepairContext context, int power, int year)
            {
                var queryLINQ = context.Cars.Where(c => c.CarId < 50 && c.Power > 500 && c.Year > 2010);

                foreach (var c in queryLINQ)
                {
                    Console.WriteLine(c.ToString());
                }
            }

            // 3.Выборку данных, сгруппированных по любому из полей данных с выводом какого - либо итогового результата
            // (min, max, avg, сount или др.) по выбранному полю из таблицы, стоящей в схеме базы данных на стороне отношения «многие» – 1 шт.

            // Вывод кол-во автомобилей для каждого года
            static void SelectGroupByYearCars(AutorepairContext context)
            {
                var queryLINQ = from c in context.Cars
                                group c.CarId by c.Year into f
                                select new
                                {
                                    Year = f.Key,
                                    Average = f.Count()
                                };
                foreach (var c in queryLINQ)
                {
                    Console.WriteLine(c.ToString());
                }
            }



            // 4.Выборку данных из двух полей двух таблиц, связанных между собой отношением «один - ко - многим» – 1 шт.
            static void SelectMechanicAndQualification(AutorepairContext context, int recordsNum)
            {
                var queryLINQ = from m in context.Mechanics
                                join q in context.Qualifications
                                on m.QualificationId equals q.QualificationId
                                select new
                                {
                                    MechId = m.MechanicId,
                                    FirstName = m.FirstName,
                                    MiddleName = m.MiddleName,
                                    LastName = m.LastName,
                                    QualifName = q.Name,
                                    MechExp = m.Experience,
                                    QualifSalary = q.Salary,
                                };
                foreach (var c in queryLINQ.Take(recordsNum).ToList())
                {
                    Console.WriteLine(c.MechId + " " + c.FirstName + " " + c.MiddleName + " " + c.LastName + " " + c.QualifName + " " + c.MechExp + " " + c.QualifSalary);
                }

            }

            // 5.Выборку данных из двух таблиц, связанных между собой отношением «один - ко - многим» и отфильтрованным
            // по некоторому условию, налагающему ограничения на значения одного или нескольких полей – 1 шт.
            static void SelectMechanicAndQualificationByQualifNameAndExperience(AutorepairContext context, int QualificationId, int Experience, int recordsNum)
            {
                var queryLINQ = from m in context.Mechanics
                                join q in context.Qualifications
                                on m.QualificationId equals q.QualificationId
                                where (q.QualificationId > QualificationId && m.Experience > Experience)
                                select new
                                {
                                    MechId = m.MechanicId,
                                    FirstName = m.FirstName,
                                    MiddleName = m.MiddleName,
                                    LastName = m.LastName,
                                    QualifName = q.Name,
                                    MechExp = m.Experience,
                                    QualifSalary = q.Salary,
                                };
                foreach (var c in queryLINQ.Take(recordsNum).ToList())
                {
                    Console.WriteLine(c.MechId + " " + c.FirstName + " " + c.MiddleName + " " + c.LastName + " " + c.QualifName + " " + c.MechExp + " " + c.QualifSalary);
                }
            }

            // 6.Вставку данных в таблицы, стоящей на стороне отношения «Один» – 1 шт.
            // 7.Вставку данных в таблицы, стоящей на стороне отношения «Многие» – 1 шт.
            static void Insert(AutorepairContext context)
            {
                // Создать новую должность 
                Qualification qualification = new Qualification
                {
                    Name = "6 разряд",
                    Salary = 1300,

                };

                // Добавить в DbSet
                context.Qualifications.Add(qualification);
                // Сохранить изменения в базе данных
                context.SaveChanges();
                Console.WriteLine("Должность была добавлена: ");
                Console.WriteLine(qualification.ToString());

                // Создать механика с должностью выше
                Mechanic mechanic = new Mechanic
                {
                    FirstName = "Ivan",
                    MiddleName = "Ivanov",
                    LastName = "Ivanovich",
                    QualificationId = qualification.QualificationId,
                    Experience = 21,
                };
                Mechanic mechanic2 = new Mechanic
                {
                    FirstName = "Aleksey",
                    MiddleName = "Lipov",
                    LastName = "Sergeevich",
                    QualificationId = qualification.QualificationId,
                    Experience = 15,
                };
                Console.WriteLine("Механик был добавлен: ");
                Console.WriteLine(mechanic.ToString());
                Console.WriteLine(mechanic2.ToString());

                // Добавить в DbSet
                context.Mechanics.Add(mechanic);
                context.Mechanics.Add(mechanic2);
                // Сохранить изменения в базе данных
                context.SaveChanges();

            }

            // 8.Удаление данных из таблицы, стоящей на стороне отношения «Один» – 1 шт.
            // 9.Удаление данных из таблицы, стоящей на стороне отношения «Многие» – 1 шт.
            static void DeleteByQualificationAndMechanicWithQualification(AutorepairContext context, string nameQualification)
            {
                IQueryable<Qualification> qualification = context.Qualifications.Where(q => q.Name == nameQualification);

                context.Qualifications.RemoveRange(qualification);
                context.SaveChanges();

                Console.WriteLine($"Должность {nameQualification} была удалена с БД!");
            }

            static void DeleteByMechanic(AutorepairContext context, string firstName, string middleName, string lastName)
            {
                IQueryable<Mechanic> mechanics = context.Mechanics.Where(m => m.FirstName == firstName && m.LastName == lastName && m.MiddleName == middleName);

                foreach (Mechanic m in mechanics)
                {
                    Console.WriteLine($"Механик {m.MechanicId} {m.FirstName} {m.MiddleName} {m.LastName}  был удален с БД!");
                }

                context.Mechanics.RemoveRange(mechanics);
                context.SaveChanges();

            }

            // 10.Обновление удовлетворяющих определенному условию записей в любой из таблиц базы данных – 1 шт.
            // Изменение мощности всем автомобилям владельца.
            static void UpdatePowerCarById(AutorepairContext context, int ownerId, int powerUpd) 
            {
                IQueryable<Car> cars = context.Cars.Where(c => c.OwnerId == ownerId);

                Console.WriteLine("До/после: ");
                foreach (Car car in cars) 
                {
                    if (car != null)
                    {
                        Console.WriteLine(car.ToString());
                        car.Power = powerUpd;
                        Console.WriteLine(car.ToString());
                    }
                }
                context.SaveChanges();
                Console.WriteLine("Успешно обновлено");
            }
        }
    }
}
