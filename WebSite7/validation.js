function validationForm(empValidation) {

    
    var flag = true;

    if (empValidation !== undefined || empValidation !== null) {

        var allControll = $("." + empValidation).find(".isValid");

        $(allControll).each(function (index, element) {


            if (element.tagName === "INPUT" || element.tagName === "SELECT" || element.tagName === "TEXTAREA") {


                if (element.type === "text") {
                    if ($(element).val() === "") {
                        removeError(element);
                        $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $(element).keyup(function () {

                        if ($(element).val() === "") {
                            removeError(element);
                            $(element).after("<span class='error ' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });

                }
                
                if (element.type === "email") {
                    
                    if (!ValidateEmail($(element).val())) {
                       removeError(element);
                        $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }


                    $(element).keyup(function () {
                       
                        if ($(element).val() === "") {
                          removeError(element);
                            $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });
                }

                if (element.type === "checkbox") {
                    if ($('input[type=checkbox]:checked').length === 0) {
                        removeError(element);

                        $(element).after("<span class='error abhi' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $("input[type='checkbox']").click(function () {

                        if ($('input[type=checkbox]:checked').length === 0) {
                            removeError(element);

                            $(element).after("<span class='error abhi' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });
                }

                if (element.type === "radio") {
                    if ($('input[type=radio]:checked').length === 0) {
                        removeError(element);
                        $(element).after("<span class='error abhi' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $("input[type='radio']").click(function () {

                        if ($('input[type=radio]:checked').length === 0) {
                            removeError(element);
                            $(element).after("<span class='error abhi' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });
                }

                if (element.type === "file") {
                    if ($(element).val() === "") {
                        removeError(element);
                        $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $(element).on("change", function () {

                        if ($(element).val() === "") {
                            removeError(element);
                            $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });
                }

                if (element.type === "tel") {
                    if (!phonenumber($(element).val())) {
                        removeError(element);
                        $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $(element).keyup(function () {

                        if ($(element).val() === "") {
                            removeError(element);
                            $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });
                }

                if (element.tagName === "TEXTAREA") {
                    if ($(element).val() === "") {
                        removeError(element);
                        $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $(element).keyup(function () {

                        if ($(element).val() === "") {
                            removeError(element);
                            $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });
                }

                if (element.tagName === "SELECT") {
                    if ($(element).val() === "") {
                        removeError(element);
                        $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                        flag = false;
                    } else {
                        removeError(element);
                    }

                    $(element).on("change", function () {

                        if ($(element).val() === "") {
                            removeError(element);
                            $(element).after("<span class='error' id=" + element.id + " style=color:red>" + element.attributes["data-error"].value + "</span>");
                            flag = false;
                        } else {
                            removeError(element);
                        }

                    });

                }

            }
        });
        return true;

    }


}

function removeError(element) {


    if ($(element).parents(".form-group").find(".error")) {

        var ele = $("#" + element.id).parents(".form-group");
        var eleData = ele.find("span#" + element.id + ".error");
        eleData.remove();
    }
}

function ValidateEmail(email) {
    var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
    return expr.test(email);
}


function phonenumber(inputtxt) {
    var phoneno = /^\d{10}$/;
    return phoneno.test(inputtxt);
}

