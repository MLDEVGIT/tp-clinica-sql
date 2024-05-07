
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
       Console.WriteLine("INSERT INTO Clinica.Turno (Fecha, Hora, LugarDeAtencion_id,  Paciente_id, TurnoStatus, Estudio_id) VALUES ");

        bool isFirst = true;

        foreach (string date in dates)
        {
          foreach (string hora in horas)
          {
            foreach (int lugar in lugarDeAtencion_id)
            { 
              if (isFirst)
              {
               Console.WriteLine($"('{date}', '{hora}', {lugar}, NULL, {(int)turnoStatus}, NULL)");

                isFirst = false;
              }
              else {

              Console.WriteLine($",('{date}', '{hora}', {lugar}, NULL, {(int)turnoStatus}, NULL)");

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
        /*
        INSERT INTO Clinica.Estudio (Descripcion) VALUES
        ('Análisis de Sangre (con ayuno)'),
        ('Análisis Dengue (sin ayuno)'),
        ('Ecografia'),
        ('Electrocardiograma'),
        ('Radiografia'),
        ('Tomografia');

        INSERT INTO Clinica.LugarDeAtencion (Descripcion) VALUES
        ('Box Laboratorio 1'),
        ('Box Laboratorio 2'),
        ('Box Laboratorio 3'),
        ('Consultorio 1'),
        ('Consultorio 2'),
        ('Consultorio 3'),
        ('Sala de Rayos X'),
        ('Tomógrafo');
          */
          /*

          Agenda de turnos: Todos los estudios se realizan con turno,
          menos los estudios de laboratorio y los derivados de Guardia Médica / Internación. 
          Horarios de laboratorio Estudios que requieren ayuno previo. 7:00 a 11:00 hs. Estudios que no requieren ayuno. 7:00 a 17:00 hs.
          */
        int[] lugarDeAtencion_id = {1, 2, 3};
 
        ImprimirInserts(
          GenerarFechas("2024-05-01", "2024-06-30"), 
          GenerarHoras("07:00:00", "17:00:00"), 
          lugarDeAtencion_id, 
          TurnoStatus.Disponible);


        lugarDeAtencion_id = new int[] {4, 5, 6};
         ImprimirInserts(
          GenerarFechas("2024-05-01", "2024-06-30"), 
          GenerarHoras("08:00:00", "18:00:00"), 
          lugarDeAtencion_id, 
          TurnoStatus.Disponible);

         lugarDeAtencion_id = new int[] {7, 8};
         ImprimirInserts(
          GenerarFechas("2024-05-01", "2024-06-30"), 
          GenerarHoras("00:00:00", "23:30:00"), 
          lugarDeAtencion_id, 
         TurnoStatus.Disponible);
         
       
    }
}