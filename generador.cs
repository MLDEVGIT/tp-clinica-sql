using System;
using System.Collections.Generic;

public class GeneradorInserts
{
enum TurnoStatus {
  NoDisponible = 0,
  Disponible = 1,
  Ocupado = 2
}
     private static void ImprimirInserts (List<string> dates, List<string> horas,int[]lugarDeAtencion_id, TurnoStatus turnoStatus) {
       Console.WriteLine("INSERT INTO Clinica.Turno (Fecha, Hora, LugarDeAtencion_id,  Paciente_id, TurnoStatus) VALUES ");

        bool isFirst = true;

        foreach (string date in dates)
        {
          foreach (string hora in horas)
          {
            foreach (int lugar in lugarDeAtencion_id)
            { 
              if (isFirst)
              {
                Console.WriteLine("('" + date + "', '" + hora + "', " + lugar + ",  NULL,  " + ((int)turnoStatus) + ")");
                isFirst = false;
              }
              else {

              Console.WriteLine(",('" + date + "', '" + hora + "', " + lugar + ",  NULL,  " +((int)turnoStatus) + ")");
              }
            }
          }
        }
        Console.WriteLine(";\n");
    }

    public static List<string> GenerarFechas(string fechaInicio, string fechaFin) {
        List<string> dates = new List<string>();
        for (DateTime date = DateTime.Parse(fechaInicio); date <= DateTime.Parse(fechaFin); date = date.AddDays(1))
        {
            dates.Add(date.ToString("yyyy-MM-dd"));
        }
        return dates;
    }

    public static List<string> GenerarHoras(string horaInicio, string horaFin, int intervalo = 30) {
        List<string> horas = new List<string>();
        for (DateTime hora = DateTime.Parse(horaInicio); hora <= DateTime.Parse(horaFin); hora = hora.AddMinutes(intervalo))
        {
            horas.Add(hora.ToString("HH:mm:ss"));
        }
        return horas;
    }
    public static void Main(string[] args)
    {
        
        int[] lugarDeAtencion_id = {1, 2, 3, 4, 5};

        ImprimirInserts(
          GenerarFechas("2024-05-14", "2024-05-15"), 
          GenerarHoras("00:00:00", "08:30:00"), 
          lugarDeAtencion_id, 
          TurnoStatus.NoDisponible);
        ImprimirInserts(
          GenerarFechas("2024-05-14", "2024-05-15"), 
          GenerarHoras("09:00:00", "12:00:00"), 
          lugarDeAtencion_id, 
          TurnoStatus.Disponible);
        ImprimirInserts(
          GenerarFechas("2024-05-14", "2024-05-15"), 
          GenerarHoras("12:30:00", "23:30:00"), 
          lugarDeAtencion_id, 
          TurnoStatus.NoDisponible);
       
    }
}