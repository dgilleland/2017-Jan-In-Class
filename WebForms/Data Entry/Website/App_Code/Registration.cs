using System;

/// <summary>
/// The Registration class represents student information supplied when registering at a post-secondary school.
/// </summary>
public class Registration
{
    public string FirstName { get; set; }
    public string LastName { get; set; }
    public string MiddleName { get; set; }
    public long SIN { get; set; }
    public DateTime DOB { get; set; }
    public string StudyProgram { get; set; }
    public int SchoolYear { get; set; }
}