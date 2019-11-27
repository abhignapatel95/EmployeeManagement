<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default2.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <style>
        #img {
            display: block;
        }

        .auto-style1 {
            height: 25px;
        }

        .auto-style2 {
            height: 25px;
            width: 86px;
        }

        img {
            vertical-align: middle;
            border-style: none;
            height: 100px;
        }

        .abhi {
            position: absolute;
            color: red;
            width: 100%;
            float: left;
            width: 500px;
            margin-top: 20px;
        }

        .paging-nav {
            text-align: left;
            padding-top: 2px;
        }

        .paging-nav a {
            margin: auto 1px;
            text-decoration: none;
            display: inline-block;
            padding: 1px 7px;
            background: #91b9e6;
            color: white;
            border-radius: 3px;
        }

        .paging-nav .selected-page {
            background: #187ed5;
            font-weight: bold;
        }

        .btn-success.focus, .btn-success:focus, .btn-success.hover {
            box-shadow: 0 0 0 0rem rgba(72,180,97,.5) !important;
            border-color: transparent;
        }

        .chip {
            display: inline-block;
            padding: 0 25px;
            height: 34px;
            font-size: 16px;
            line-height: 31px;
            border-radius: 25px;
            background-color: silver;
        }
    </style>
    <title>Employee Detail</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
     <%-- validation.js page--%>
    <script src="validation.js"></script>

        <%-- library link for skills sortable--%>
     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
     <script src="//code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


   <%--librabry link for alert box when delete button is presses --%> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.css">

    <%--librabry link for Paggination --%> 
    <script src="https://cdnjs.cloudflare.com/ajax/libs/twbs-pagination/1.4.2/jquery.twbsPagination.js"></script>
    
     <%--librabry link for DataTables --%> 
  <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
  <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.js"></script>

    
 
    <!-- Include Date Range Picker -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/js/bootstrap-datepicker.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.4.1/css/bootstrap-datepicker3.css" />
    <!--Font Awesome (added because you use icons in your prepend/append)-->
    <link rel='stylesheet' href='https://use.fontawesome.com/releases/v5.7.0/css/all.css' integrity='sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ' crossorigin='anonymous'>
    
        <script src="paging.js"></script>
    <script>

        var array = [];
        var myarray = [];
        var Id = [];
        var data = [];
        var index;
        var skills = [];
        var uid;
        var gender = [];
        var Hobbies = [];
        var Image;
        var deleteId;
        var Hobbies_array = [];
        var nextRowID = 0;
        var testShortData = [];
        var theArray = [];

        $(document).ready(function () {
            GetLocalStorageValuesSetInTable();
            getFromLocalstorageToArray();
            var date_input = $('input[name="date"]'); //our date input has the name "date"
            var container = $('.bootstrap-iso form').length > 0 ? $('.bootstrap-iso form').parent() : "body";
            date_input.datepicker({
                format: 'dd/mm/yyyy',
                container: container,
                todayHighlight: true,
                autoclose: true,
            });

            $('#myTable').paging({
                limit: 5,
                rowDisplayStyle: 'block',
                activePage: 0,
                rows: []

            });

            //ADD BUTTON EVENT.
            // $("#btnAdd").click(function () {
            // var abc = createRow();
            //  ("#employee-table-body").append(abc);
            //clearAll();

            //  window.location.reload();
            //  });


            // SHOW POP BUTTON OF DELTE
            $(document).on('click', '.btn-delete', function (e) {

                $("#confirm-delete").modal("show");
                deleteId = parseInt(this.attributes["cust-id"].value);

            });
            // DELETE ROW
            $(document).on('click', '.btn-ok', function (e) {

                if (deleteId) {
                    getFromLocalstorageToArray()

                    if (myarray != null && myarray.length > 0) {
                        for (var i = 0; i < myarray.length; i++) {

                            if (myarray[i].uid === deleteId) {
                                index = i;
                            }
                        }
                        myarray.splice(index, 1);
                        localStorage.setItem("employeeDetail", JSON.stringify(myarray));
                        window.location.reload();

                    }
                }
            });

            //method for edit to and set the values and //button change event when edit btn press than upate btn occur in it.
            $(document).on("click", ".btn-edit", function () {

                $("#myModal").modal();
                $("#btnAdd").hide();
                $("#btnUpd").show();

            });


            // RADIO BUTTON EVENT
            $("input[type='radio']").click(function () {
                gender = $("input[name='customRad1']:checked").val();
            });

            //Add SKills
            $(document).on("click", ".add_skills", function () {

                var skills = createSkills();
                $("#skills-table-body").append(skills);
                clearSkills()
            });

            // delete skills 
            $(document).on("click", ".btn-skillsdt", function () {

                skills;

                var itemtoRemove = this.attributes["cust"].value
                for (var i = 0; i < skills.length; i++) {
                    if (skills[i] === itemtoRemove) {
                        index = i;

                    }
                }
                skills.splice(index, 1);
                $(this).parents("tr").remove();
            });


            // model close event with reload 
            $(document).on("click", "#closeme", function () {
                window.location.reload();
                clearAll();
            });

            $(document).on("click", "#hh", function () {
                window.location.reload();
                clearAll();
            });

            //OPEN BUTTON EVENT-UPDATE BTN HIDE.
            $(document).on("click", "#mdl", function () {
                clearAll();
                $("#btnAdd").show();
                $("#btnUpd").hide();

            });

            //ADD SKILLS AND APPEND
            $("#addSkills").click(function () {

                var newskill = $("#empSkills").val();
                if (newskill != null) {
                    skills.push(newskill);
                }
            });

            $(".btn-coll").click(function () {
                var unique = this.attributes["id"].value
                var x = document.getElementById("col-title" + unique);

                if (x.style.display === "none") {
                    x.style.display = "block";
                    $(this).text("-").css({ "background": "red", "border-color": "red" })

                } else {
                    x.style.display = "none";
                    $(this).text("+").css({ "background": "green", "border-color": "green" })
                }

            });

        });

        // SORTABLE SKILLS
        $(function () {


            $("#skills-table-body").sortable({
                update: function (event, ui) {

                    save1();
                }
            });

            $("#skills-table-body").disableSelection();

            function save1() {

                theArray = [];
                $("td", "#skills-table-body").each(function (count, item) {
                    theArray[count] = $(this).text();
                });
                testShortData = theArray;
            }
        });

        function maxId(val, arr) {

            if (val === 0) {
                return 1;

            } else {

                var arrID = arr.map((data) => data.uid)
                var maxID = Math.max(...arrID);
                return maxID + 1;

            }
        }

        function createRow(empValidation) {
            try {

                if (validationForm(empValidation)) {

                    Id = maxId(myarray.length, myarray);
                    var name = $("#name").val().trim();
                    var LastName = $("#lname").val().trim();
                    var Address = $("#address").val().trim();
                    var MobileNo = $("#mobileno").val().trim();
                    var email = $("#emailId").val().trim();

                    $.each($("input[name='customcheckbox1']:checked"), function () {
                        Hobbies.push($(this).val());
                    });
                    Hobbies
                    var Designation = $("#designation").val().trim();
                    var DOB = $("#dob").val().trim();
                    var joiningDt = $("#jdt").val().trim();

                    var html = "";
                    //html += "<tr class='employee-row'>"
                    //html += "<td class='uid'>" + Id + "</td>";
                    //html += "<td class='firstname'>" + name + "</td>";
                    //html += "<td class='lastname'>" + LastName + "</td>";
                    //html += "<td class='address'>" + Address + "</td>";
                    //html += "<td class='mobileno'>" + MobileNo + "</td>";
                    //html += "<td class='email'>" + email + "</td>";
                    //html += "<td class='hobbies'>" + Hobbies + "</td>";
                    //html += "<td class='gender'>" + gender + "</td>";
                    //html += "<td class='designation'>" + Designation + "</td>";
                    //html += "<td class='skills'>" + skills + "</td>";
                    //html += "<td class='DOB'>" + DOB + "</td>";
                    //html += "<td class='joiningDate'>" + joiningDt + "</td>";
                    //html += "<td class='image'><img src= " + Image + "</td>";
                    //html += "<td><button class='btn btn-info btn-xs btn-edit'>Edit</button><button class='btn btn-danger btn-xs btn-delete'>Delete</button></td>";
                    //html += "</tr>";

                    let shortData = theArray.filter((data) => data !== "Delete")
                    shortData = shortData.length !== 0 ? shortData : skills;

                    var obj = { uid: Id, name: name, lastname: LastName, address: Address, mobileno: MobileNo, email: email, hobbies: Hobbies, gender: gender, designation: Designation, skills: shortData, DOB: DOB, joiningDt: joiningDt, Image: Image };
                    if (name !== "" && LastName !== "" && Address !== "" && MobileNo !== "" && email !== "" && gender.length !== 0 && Hobbies.length !== 0 && Designation !== "" && skills !== "" && DOB !== "" && joiningDt !== "" && Image !== "") {
                        array.push(obj);

                        window.location.reload();
                        clearAll();
                    }

                    localStorage.setItem("employeeDetail", JSON.stringify(array));
                    getFromLocalstorageToArray()

                    return html;
                }
                else {
                    alert("false");
                }
            } catch (e) {

            }
        }

        // FUNCTION FOR GETTING THE DATA FROM LOCALSTORAGE TO ARRAY
        function getFromLocalstorageToArray() {

            if (localStorage.getItem('employeeDetail') != null) {
                myarray = JSON.parse(localStorage.getItem("employeeDetail"));
            }
        }

        // function for clearing the data from textbox
        function clearAll() {

            skills = [];
            try {
                $("input[name='name']").val('');
                $("input[name='lname']").val('');
                $("textarea[name='address']").val('');
                $("input[name='mobileno']").val('');
                $("input[name='Email']").val('');
                $('input[type="checkbox"]').prop('checked', false);
                $('input[type="radio"]').prop('checked', false);
                $('#designation option').prop('selected', function () {
                    return this.defaultSelected;
                });
                $("input[name='empSkills']").val('');
                $("#skills-table-body").text('');
                $("input[name='date']").val('');
                $("input[name='date']").val('');
                $("#img").attr('src', '').css("display", "none");

            } catch (e) {

            }
        }

        //function for set the values to texbox from table
        function edit(eid) {

            myarray = JSON.parse(localStorage.getItem('employeeDetail'));
            var editData = myarray.filter((data) => data.uid === eid)
            $("#uid").val(editData[0].uid);
            $("#name").val(editData[0].name);
            $("#lname").val(editData[0].lastname);
            $("#address").val(editData[0].address);
            $("#mobileno").val(editData[0].mobileno);
            $("#emailId").val(editData[0].email);

            Hobbies_array = editData[0].hobbies;
            $.each($("input[name='customcheckbox1']"), function () {
                var n = "";
                n = Hobbies_array.includes($(this).val());
                if (n == true) {
                    $(this).prop('checked', true);
                }
            });

            gender = editData[0].gender;
            if (gender === "Male") {
                $("#customRadio1").attr('checked', 'checked');
            }
            else {
                $("#customRadio2").attr('checked', 'checked');
            }

            $("#designation").val(editData[0].designation);

            skills = editData[0].skills;
            for (i = 0; i < skills.length; i++) {

                $("#skills-table-body").append("<tr class='skills-row'><td class='skills'> " + skills[i] + "</td><td><button class='btn btn-danger btn-xs btn-skillsdt'cust=" + skills[i] + ">Delete</button></td></tr>");
            }
            //$("#empSkills").val(editData[0].skills);
            $("#dob").val(editData[0].DOB);
            $("#jdt").val(editData[0].joiningDt);

            Image = editData[0].Image;
            $("#img").attr("src", Image).css("display", "block");

        }
        function updateBtn(empValidation) {

            if (validationForm(empValidation)) {
                $.each($("input[name='customcheckbox1']:checked"), function () {
                    Hobbies.push($(this).val());
                });
                Hobbies = Hobbies;
                let shortData = theArray.filter((data) => data !== "Delete")
                shortData = shortData.length !== 0 ? shortData : skills;


                var editemp = {

                    uid: $("#uid").val(),
                    name: $("#name").val(),
                    lastname: $("#lname").val(),
                    address: $("#address").val(),
                    mobileno: $("#mobileno").val(),
                    email: $("#emailId").val(),
                    hobbies: Hobbies,
                    gender: gender,
                    designation: $("#designation").val(),
                    skills: shortData,
                    DOB: $("#dob").val(),
                    joiningDt: $("#jdt").val(),
                    Image: Image
                };

                if (editemp.uid !== "" && editemp.name !== "" && editemp.lastname !== "" && editemp.address !== "" && editemp.mobileno !== "" && editemp.email !== "" && editemp.hobbies.length !== 0 && editemp.gender.length !== 0 && editemp.designation !== "" && editemp.skills !== "" && editemp.DOB !== "" && editemp.joiningDt !== "" && editemp.Image.length !== 0) {
                    updateValues(editemp);
                } else {
                    (validationForm(empValidation))

                }

            }
        }

        //edit and update the values in tables:
        function updateValues(editValue) {

            try {

                myarray = JSON.parse(localStorage.getItem("employeeDetail"));
                editValue.uid = parseInt(editValue.uid);
                var pos;

                for (var i = 0; i < myarray.length; i++) {

                    if (myarray[i].uid === editValue.uid) {
                        pos = i;
                    }
                }

                myarray[pos] = editValue;
                localStorage.setItem("employeeDetail", JSON.stringify(myarray));
                window.location.reload();
            } catch (e) {

            }

        }

        //fumction for createskills

        function createSkills() {
            try {

                sid = ++nextRowID;
                var skills = $("#empSkills").val();
                var html = "";
                html += "<tr class='skills-row'>"
                html += "<td class='skills' id=" + sid + "> " + skills + "</td>";
                html += "<td><button class='btn btn-danger btn-xs btn-skillsdt'  cust=" + skills + ">Delete</button></td>";
                html += "</tr>";
                return html;
            } catch (e) {

            }

        }

        function clearSkills() {
            try {
                $("input[name='empSkills']").val('');

            } catch (e) {

            }

        }

        function GetLocalStorageValuesSetInTable() {
            try {

                if (localStorage.getItem('employeeDetail') !== undefined && localStorage.getItem('employeeDetail') !== null) {
                    array = JSON.parse(localStorage.getItem('employeeDetail'));
                    if (array.length > 0) {
                        for (var i = 0; i < array.length; i++) {

                            var nameArr = array[i].skills;
                            var chips = "";
                            for (var j = 0; j < nameArr.length; j++) {
                                chips += '<span class="chip">' + nameArr[j] + '</span>';
                            }
                            chips = chips.length === 0 ? "Skill not defined. " : chips;

                            imgg = array[i].Image;
                            imgg = imgg.length === 0 ? " image not uploaded." : imgg;
                            var html = "";
                            html += "<tr class='employee-row'>"
                            html += "<td><button type='button' id=" + array[i].uid + " class='btn btn-success btn-coll ' cust-id=" + array[i].uid + " >+</button></td>";
                            html += "<td class='uid' >" + array[i].uid + "</td>";
                            html += "<td class='firstname'>" + array[i].name + "</td>";
                            html += "<td class='lastname'>" + array[i].lastname + "</td>";
                            html += "<td class='address'>" + array[i].address + "</td>";
                            html += "<td class='mobileno'>" + array[i].mobileno + "</td>";
                            html += "<td class='image'><img src=" + imgg + " /></td>";
                            html += "<td><button class='btn btn-info btn-xs btn-edit' onclick='edit(" + array[i].uid + ");' cust-id=" + array[i].uid + " >Edit</button><button class='btn btn-danger btn-xs btn-delete'   cust-id=" + array[i].uid + ">Delete</button></td>";
                            html += "<tr id=" + 'col-title' + array[i].uid + " style='display: none;'><td colspan='7'><table>"
                            html += "<tr><td style='width: 190px;' >Email:</td><td class='email'>" + array[i].email + "</td></tr>";
                            html += "<tr><td>Hobbies:</td><td class='hobbies'>" + array[i].hobbies + "</td></tr>";
                            html += "<tr><td>gender:</td><td class='gender'>" + array[i].gender + "</td></tr>";
                            html += "<tr><td>Designation:</td><td class='designation'>" + array[i].designation + "</td></tr>";
                            html += "<tr><td>skills:</td><td class='skills'><div>" + chips + "</div></td></tr>";
                            html += "<tr><td>DOB:</td><td class='DOB'>" + array[i].DOB + "</td></tr>";
                            html += "<tr><td>JoiningDate:</td><td class='joiningDate'>" + array[i].joiningDt + "</td></tr>";
                            html += "</table></tr></td>";

                            $("#employee-table-body").append(html);
                        }
                    }
                }
            } catch (e) {

            }
        }

        //image
        function readURL(input) {
            $("#img").css("display", "block");
            if (input.files && input.files[0]) {
                var reader = new FileReader();


                reader.onload = function (e) {
                    $("#img").attr('src', e.target.result);
                    Image = e.target.result;
                }

                reader.readAsDataURL(input.files[0]);

            }
        }
        $("#emp_Image").change(function () {
            readURL(this);
        });

    </script>
</head>
<body>

    <div class=" m-1">
        <h2>Employee Form:</h2>
        <!-- Button to Open the Modal -->
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal" id="mdl" style="width: 134px; height: 51px">
            Open 
        </button>

        <div class="jumbotron-fluid">
            <h1>Employee Data</h1>
            <table class="table table-bordered small" id="myTable">
                <thead>
                <tr>
                    <th>Collaps</th>
                   <th>uid</th>
                    <th>Name</th>
                    <th>LastName</th>
                    <th>Address</th>
                    <th>Mobile No:</th>
                    <th>Image</th>
                    <th>Action</th>
    <%--            <th>EmailId:</th>
                    <th>Hobbies</th>
                    <th>gender</th>
                    <th>Designation</th>
                    <th>skills</th>
                    <th>DOB</th>
                    <th>joining Date</th>
                    <th>Image</th>
                    --%>
                </tr>
                </thead>
                <tbody id="employee-table-body">
                </tbody>
        </table>

       </div>
        </div>
        
        <%--modal for Delete ALert start--%>

   <div class="modal fade"  id='confirm-delete'  tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Alert</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <p>Do you want to delete this record?</p>
      </div>
      <div class="modal-footer">
      <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
      <button id="btn-ok" type="button"  class="btn btn-danger btn-ok">Delete</button>
      </div>
    </div>
  </div>
</div>
    <%--modal for Delete ALert End--%>

        <!-- The Modal -->
        <div class="modal fade" id="myModal">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h4 class="modal-title">Employee Detaii:</h4>
                        <button type="button" id="hh" class="close" data-dismiss="modal">×</button>
                    </div>

                    <!-- Modal body -->
                    <div class="modal-body">



                        <div class="container">

                            <form name="myForm" class="empValidation">
                                <div class="form-group">
                                     <div class="row">
                                        <div class="col">
                                            <label for="uid" id="uid"></label>
                                            <label for="name" id="firsname"><b>Name</b></label>
                                            <input type="text" class="form-control isValid" id="name" data-error="Please enter Name." placeholder="Enter Name" name="name" value="" required="" /><br />
                                        </div>
                                        <div class="col">
                                            <label for="lname"><b>LastName</b></label>
                                            <input type="text" class="form-control isValid" id="lname" data-error="Please enter Lastname." placeholder="Enter LastName" name="lname" value="" required="" /><br />
                                        </div>
                                    </div>
                                    <label for="address"><b>Address</b></label>
                                    <textarea class="form-control isValid" id="address" data-error="Please enter Address." placeholder="Enter Address" name="address" cols="10" rows="2"></textarea><br />
                                    <div class="row">
                                        <div class="col">
                                            <label for="mobileno"><b>MobileNo:</b></label>
                                            <input type="tel" class="form-control isValid" maxlength="10" id="mobileno" data-error="Please enter MobileNo." placeholder="Enter MobileNo" name="mobileno" value="" required="" />
                                        </div>
                                        <div class="col">
                                            <label for="emailId"><b>EmailId:</b></label>
                                            <input type="email"  class="form-control isValid" id="emailId" data-error="Please enter Valid EmailId." placeholder="Enter EmailId" name="Email" value="" required="" />
                                        </div>
                                    </div>
                                
                                <div class="row">
                                    <div class="col">
                                        <label><b>Hobbies:</b></label>
                                        <div>

                                            <div class="custom-control custom-checkbox custom-control-inline  "  >
                                                <input type="checkbox" class="custom-control-input isValid"  data-error="Please Select Hobbies." id="checkbox1" name="customcheckbox1" value="cricket" style="width:100%";/>
                                                <label class="custom-control-label" for="checkbox1">cricket</label>
                                                
                                            </div>
                                            <div class="custom-control custom-checkbox custom-control-inline">
                                                
                                                <input type="checkbox" class="custom-control-input " id="checkbox2" name="customcheckbox1" value="Vollyball" style="width:100%"; />
                                                <label class="custom-control-label" for="checkbox2">Vollyball</label>
                                                
                                                <br />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <br />
                                        <label><b>gender:</b></label>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" class="custom-control-input isValid "  data-error="Please Select gender." id="customRadio1" name="customRad1" value="Male" />
                                            <label class="custom-control-label" for="customRadio1">Male</label><br />
                                        </div>
                                        <div class="custom-control custom-radio custom-control-inline">
                                            <input type="radio" class="custom-control-input  " id="customRadio2" name="customRad1" value="Female" />
                                            <label class="custom-control-label" for="customRadio2">Female</label><br />
                                        </div>
                                    </div>
                                </div>
                                <br />
                                <label><b>Designation</b></label>
                                <select name="designation" class="custom-select isValid " data-error="Please select Designation." id="designation">

                                    <option selected></option>
                                    <option value="Senior Developer">Senior Developer</option>
                                    <option value="Junior Developer">Junior Developer</option>
                                    <option value="Project Manager">Project Manager</option>
                                    <option value="Team Leader">Team Leader</option>
                                </select><br />
                                
                                    <div class="row">
                                        <div class="col">
                                            <label for="empSkills"><b>skills</b></label>
                                            <input type="text" class="form-control " data-error="Please select skills." id="empSkills" placeholder="Enter skills" name="empSkills" />
                                            
                                        </div>
                                        <div class="col">
                                            <br />
                                            <button type="button" class="btn btn-success add_skills" id="addSkills">Add</button>
                                        </div>
                                    </div>
                                    <h3><span id="sortable-9"></span></h3>
                                    <table class="table table-bordered small" id="skillsTable">
                                        <tbody id="skills-table-body">
                                        </tbody>
                                    </table>
                                  
                              
                                    
                                    <label for="dob"><b>DOB</b></label>
                                    <div class="input-group">
                                        <input type="text"  class="form-control isValid" data-error="Please Select DOB." id="dob" name="date" placeholder="DD/MM/YYYY" style="width:100%"; />
                                        <br />
                                        <br />
                                        </div>
                                    

                                    <label for="jdt"><b>JoiningDate</b></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control isValid" data-error="Please Select JoiningDate." id="jdt" name="date" placeholder="DD/MM/YYYY" style="width:100%"; />
                                        
                                    </div>
                                    <div class="row">
                                        <div class="col">
                                            <p><b>Image:</b></p>
                                            
                                              <div class="form-group">
                                                <input type="file" class="form-control-file file-input isValid" data-error="Please Select Image." onchange="readURL(this);" id="emp_Image" name="emp_Image[]" accept="image/*">
                                              </div>
                                        <div class="col">
                                            <img src="prw" id="img" style="width: 112px; height: 112px;" />
                                        </div>
                                    </div>
                                </div>

                                <button type="button" id="btnAdd" onclick="createRow('empValidation');" class="btn btn-primary">Submit</button>
                                <button type="button" id="btnUpd" onclick="updateBtn('empValidation')" class="btn btn-primary">Update</button>
                                <span class="active" style="color: red"></span>
                                     </div>
                            </form>
                        </div>



                   


                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" id="closeme" data-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>

    </div>

</body>
</html>
