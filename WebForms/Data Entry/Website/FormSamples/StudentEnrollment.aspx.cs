using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FormSamples_StudentEnrollment : System.Web.UI.Page
{
    // This is very volatile - we're going to toss this later on
    // in favor of a database.
    // We'll use a static field that is initialized from the start
    private static List<Registration> Registrations =
        new List<Registration>();

    protected void Page_Load(object sender, EventArgs e)
    {
        if(!IsPostBack)
        {
            // Here I want to do the one-time setup on the "first" visit to the page
            // Tell my GridView to get its data from the Registrations field.
            RegistrationGridView.DataSource = Registrations;
            // Tell my GridView to loop through the Data and populate the GridView.
            RegistrationGridView.DataBind();


            int year = DateTime.Today.Year + 1;
            int endYear = year + 4;
            while(year < endYear)
            {
                SchoolYear.Items.Add(year.ToString());
                year = year + 1;
            }
        }
    }

    private bool IsDuplicateSIN()
    {
        bool isDuplicate = false;
        long sin;
        long.TryParse(SocialInsuranceNumber.Text, out sin);
        foreach (var item in Registrations)
            if (item.SIN == sin)
                isDuplicate = true;
        return isDuplicate;
    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        if (IsDuplicateSIN())
            MessageLabel.Text = "Duplicate Social Insurance Numbers are not allowed";
        else if (IsValid)
        {
            Registration newStudent = new Registration();
            newStudent.FirstName = FirstName.Text;
            newStudent.LastName = LastName.Text;
            newStudent.MiddleName = MiddleName.Text;
            newStudent.SIN = long.Parse(SocialInsuranceNumber.Text);
            newStudent.DOB = DateTime.Parse(DateOfBirth.Text);
            newStudent.StudyProgram = ProgramOfStudy.SelectedValue;
            newStudent.SchoolYear = int.Parse(SchoolYear.SelectedValue);

            // Add the student to the list
            Registrations.Add(newStudent);

            // Show the data in the GridView
            RegistrationGridView.DataSource = Registrations;
            RegistrationGridView.DataBind();

            // Give the user some friendly feedback.
            MessageLabel.Text = "Thank you for registering. A confirmation letter will be sent to you in the next few days.";
        }
    }
}