using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class FormSamples_StudentEnrollment : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Submit_Click(object sender, EventArgs e)
    {
        //if (string.IsNullOrEmpty(FirstName.Text))
        //    MessageLabel.Text = "You must enter a First Name before clicking Submit";
        //else
        //    MessageLabel.Text = "Hello " + FirstName.Text;

        MessageLabel.Text = "Hello " + FirstName.Text + " " + LastName.Text;
        MessageLabel.Text += "<br />Your SIN is <b>" + SocialInsuranceNumber.Text + "</b>";
        MessageLabel.Text += "Your birthdate is " + DateOfBirth.Text;
    }
}