import css from "../css/app.css"

import 'formBuilder';
import swal from 'sweetalert2';

jQuery(function ($) {
    var fbTemplate = document.getElementById('build-wrap');
    var options = {
        onSave: function (evt, formData) {
            let key = uid();

            console.log(key);
            console.log(formData);

            $.ajax({
                method: "POST",
                data: { key, formData },
                url: "/save_form",
                success: function (msg) {
                    swal({
                        title: "Form saved successfully.",
                        html:
                            '<p>Form key: ' + key + '</p>' +
                            '<a href="/fill_form">Fill your form.</a>',
                        confirmButtonText: 'Close',
                        type: "success",
                    });
                },
                error: function (xhr, status) {
                    swal({
                        text: "Error!",
                        type: "error",
                    });
                }
            });
        }
    };
    $(fbTemplate).formBuilder(options);
});

function uid() {
    return '' + Math.random().toString(36).substr(2, 16);
};

$("#get_form").click(function () {
    let key = $('#key_input').val();

    $.ajax({
        method: "POST",
        data: { key },
        url: "/get_form",
        success: function (msg) {
            let data = msg.response;
            $('.render-wrap').formRender({
                dataType: 'json',
                formData: data
            });

            $('.render-wrap').append("<button style='margin-top: 5vh;' type='button' id='submit_form' class='btn btn-outline-primary'>Submit Form</button>");
        },
        error: function (xhr, status) {
            swal({
                text: "Error!",
                type: "error",
            });
        }
    });
});

$('.render-wrap').on('click', '#submit_form', function () {
    let results = $('.render-wrap').formRender('userData');
    let key = $('#key_input').val();

    $.ajax({
        method: "POST",
        data: { key, results },
        url: "/save_results",
        success: function (msg) {
            swal({
                text: "Form submitted successfully!",
                type: "success",
            });
        },
        error: function (xhr, status) {
            swal({
                text: "Error!",
                type: "error",
            });
        }
    });

});



$('.input-group-append').on('click', '#get_results', function () {
    let key = $('#key_input').val();

    $.ajax({
        method: "POST",
        data: { key },
        url: "/get_results",
        success: function (msg) {
            console.log(msg.list);
            console.log(msg.count);
            let list = msg.list;
            let count = msg.count;

            $('.results_count').append("<p>Results count: " + count + "</p>");

            for (var i = 0; i < list.length; i++) {
                $('.results').append("<p>" + list[i].label + " (" + list[i].input + ")" + "</p>");
                $('.results').append("<canvas style='margin-bottom: 10vh;' id='myChart"+ i + "'></canvas>");

                var arr = list[i].values;

                var uniqs = arr.reduce((acc, val) => {
                    acc[val] = acc[val] === undefined ? 1 : acc[val] += 1;
                    return acc;
                }, {});

                let answers = Object.keys(uniqs);
             
                let counts = Object.values(uniqs);
             
                // let answers = Object.keys(uniqs);
                // console.log(answers);

                // let counts = Object.values(uniqs);
                // console.log(counts);

                var coloR = [];

                for (var y = 0; y < answers.length; y++){
                    coloR.push(color());
                }

                console.log(coloR);


                let data = {
                    datasets: [{
                        data: counts,
                        backgroundColor: coloR
                    }],

                    // These labels appear in the legend and in the tooltips when hovering different arcs
                    labels: answers
                };

                var ctx = document.getElementById('myChart'+ i);

                var myPieChart = new Chart(ctx,{
                    type: 'pie',
                    data: data,
                    options: {}
                });

            }

        },
        error: function (xhr, status) {
            swal({
                text: "Error!",
                type: "error",
            });
        }
    });

});

function color() {
    var r = Math.floor(Math.random() * 255);
    var g = Math.floor(Math.random() * 255);
    var b = Math.floor(Math.random() * 255);
    return "rgb(" + r + "," + g + "," + b + ")";
};