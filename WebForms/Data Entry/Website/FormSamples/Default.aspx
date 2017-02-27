<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="FormSamples_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    <!-- Bootstrap styling -->
    <div class="page-header">
        <h1>Data Entry Form Demos</h1>
        <blockquote>A collection of assorted forms for basic data entry.</blockquote>
    </div>

    <div class="row">
        <div class="col-md-3">
            <h1>Student Enrollment</h1>
            <p>
                This illustrates some simple controls to enroll a student in a particular course.
                The design uses only the basic Boostrap form classes
                (the <code style="font-style:normal;">form-control</code> class on form elements.
            </p>
            <p><a href="StudentEnrollment.aspx">Jump to Demo &hellip;</a></p>
        </div>
        <div class="col-md-3">
            <h1>Job Application</h1>
            <p><a href="JobApplication.aspx">Jump to Demo &hellip;</a></p>
        </div>
        <div class="col-md-3">
            <h1>Bank Account</h1>
            <p><a href="CreateBankAccount.aspx">Jump to Demo &hellip;</a></p>
        </div>
        <div class="col-md-3">
            <h1>Contest Entry</h1>
            <p><a href="ContestEntry.aspx">Jump to Demo &hellip;</a></p>
        </div>
    </div>
</asp:Content>

