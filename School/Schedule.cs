//------------------------------------------------------------------------------
// <auto-generated>
//     Этот код создан по шаблону.
//
//     Изменения, вносимые в этот файл вручную, могут привести к непредвиденной работе приложения.
//     Изменения, вносимые в этот файл вручную, будут перезаписаны при повторном создании кода.
// </auto-generated>
//------------------------------------------------------------------------------

namespace School
{
    using System;
    using System.Collections.Generic;
    
    public partial class Schedule
    {
        public int id { get; set; }
        public Nullable<int> NumberCabinet { get; set; }
        public Nullable<int> idLessonEmloyee { get; set; }
        public Nullable<System.TimeSpan> DataTimeStart { get; set; }
        public Nullable<System.TimeSpan> DataTimeFinich { get; set; }
        public bool Activ { get; set; }
    
        public virtual LessonEmployee LessonEmployee { get; set; }
    }
}
