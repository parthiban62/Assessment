var conceptOwl = (function(){
    return {
        load_mathjax: function(){
            MathJax.Hub.Config({
                jax: ["input/TeX","output/HTML-CSS","input/MathML","input/AsciiMath"],
                extensions: ["tex2jax.js"],
                tex2jax: {
                    inlineMath: [ ['$','$'], ["\\(","\\)"] ],
                    displayMath: [ ['$$','$$'], ["\\[","\\]"] ],
                    processEscapes: true
                }
            });
        },
        preview_question: function(){
            $('#preview_question_button').click(function(event){
                event.preventDefault();
                var active_content = $('ul#_cpt_question_tabs li.active').data('content');
                if(active_content !== "" || active_content != undefined){
                    if(active_content == 'question'){
                        var value = CKEDITOR.instances['question_question'].getData();
                    }else if(active_content == 'solution'){
                        var value = CKEDITOR.instances['question_solution'].getData();
                    }

                    $('#_cpt_owl_preview_container').html(value);
                    MathJax.Hub.Queue(["Typeset", MathJax.Hub, value]);
                }
            });
        },
        preview_solution: function(){
            $('.preview_solution_button').click(function(event){
                event.preventDefault();            
                var value = CKEDITOR.instances['question_paper_solution_solution_content'].getData();
                $('#_solution_preview_container').html(value);
                MathJax.Hub.Queue(["Typeset", MathJax.Hub, value]);
            });
        },
        preview_paragraph: function(){
            $('#preview_paragraph_button').click(function(event){
                event.preventDefault();
                var value = CKEDITOR.instances['paragraph_content'].getData();
                $('#_cpt_owl_preview_container').html(value);
                MathJax.Hub.Queue(["Typeset", MathJax.Hub, value]);
            });
        },
        preview_answers: function(){
            $('._cpt_answer_preview_button').click(function(event){
                event.preventDefault();
                var current_element = $(this);
                var value = CKEDITOR.instances[current_element.data('content')].getData();
                $('#_cpt_owl_preview_container').html(value);
                MathJax.Hub.Queue(["Typeset", MathJax.Hub, value]);
            });
        },
        preview_hints: function(){
            $('.preview_hint_radio_button').click(function(event){
                event.preventDefault();
                var current_element = $(this);
                var value = CKEDITOR.instances[current_element.data('content')].getData();
                $('#_cpt_owl_preview_container').html(value);
                MathJax.Hub.Queue(["Typeset", MathJax.Hub, value]);
            });
        },
        toggle_correct_checkbox: function(){
            $('input[type="checkbox"].correct_answer_chk_box').on('change', function() {
                $('input[type="checkbox"].correct_answer_chk_box').not(this).prop('checked', false);
            });
        },
        validate_multiple_correct: function(){
            $("form").submit(function( event ){
                var count = $('input[type="checkbox"].correct_answer_chk_box').filter(':checked').length ;
                if (count < 1) {
                    alert( "Please select at least one answer....! " );
                    event.preventDefault();
                }
            });
        },
        select_question_topic_tag: function(){
            $('#topic_tags_list').click(function(event){
                event.preventDefault();
                var current_element = $(this);
                var selected_subject = $('#question_subject_id');
                $('.tag_id_box').val(current_element.val())
            });
        },
        add_question_tags: function(){
            $('#_cpt_add_tags_button').click(function(event){
                event.preventDefault();
                var current_element = $('#topic_tags_list option:selected');
                if(current_element.val() == '' || current_element.val() == undefined || current_element.text() == 'Topic Tags'){
                    alert("Please Select Topic Tag");
                    return;
                }
                var current_tags = $('#_cpt_question_current_tags');
                var current_tag_ids = $('#_cpt_current_tag_ids');
                var selected_topic_tag_id = $('#_cpt_selected_topic_tag');
                var current_subject = $('#question_tag_subject_name');
                if(current_tags.html() != undefined || current_tags.html() != ""){
                    var tag_names = current_tags.text() ? current_tags.text() + ',' + current_element.text() + '(' + current_subject.val() + ')' : current_element.text() + '(' + current_subject.val() + ')';
                    var tag_ids = current_tag_ids.val() ? current_tag_ids.val() + ',' + selected_topic_tag_id.val() : selected_topic_tag_id.val();
                }else{
                    var tag_names = current_element.text() + '(' + current_subject.val() + ')';
                    var tag_ids = selected_topic_tag_id.val();
                }
                $('#_cpt_current_tag_ids').val(tag_ids);
                $('#_cpt_question_current_tags').html(tag_names);
            });
        },
        delete_question_tag: function(){
            $('#_cpt_delete_question_tag_button').click(function(event){
                event.preventDefault();
                $('#_cpt_current_tag_ids').val('');
                $('#_cpt_selected_topic_tag').val('');
                $('#_cpt_question_current_tags').html('');
            });
        },
        setup_datatable: function(){
            $('#_cpt_table_list').DataTable();
        },
        init_datapagination: function(){
            $('#_cpt_table_list').dataTable( {
                drawCallback: function( oSettings ) {
                    conceptOwl.initialize_tag_fixing();
                }
            } );
        },
        setup_tagging_datatable: function(){
            $('.cpt_table_list_tagging').DataTable();
        },
        init_datapagination: function(){
            $('#_cpt_table_list_tagging').dataTable( {
                drawCallback: function( oSettings ) {
                    conceptOwl.initialize_tag_fixing();
                }
            } );
        },
        initialize_allot_actions: function(){
            $('#_cpt_qc_operator_dropdown').hide();
            $('#_cpt_qc_status').change(function(){
                $('#_cpt_qc_operator_dropdown').hide();
                $('#_cpt_qc_operator_dropdown').val('');
                if($(this).val() == "assigned_for_qc"){
                    $('#_cpt_qc_operator_dropdown').show();
                }
            });
        },
        initialize_tag_fixing: function(){
            $('.view_tag_page').change(function(){
                var subject = $( ".view_tag_page option:selected" ).val();
                $.ajax({
                    url: "/find/subject_tags",
                    type: "GET",
                    data: { 'subject' : subject, 'is_active' : "true"}
                })
            });

            $('.tag_add_in_text_box').click(function(event){
                event.preventDefault();
                var current_element = $(this);
                var topic = $( "#topic_tags option:selected" ).text();
                var topic_id = $( "#topic_tags option:selected" ).val();
                console.log(topic);
                if(topic == 'Topic tags'){
                    alert("Please Select Topic Tag");
                    return
                }
                $('.tag_id_box').val(topic_id);
                var a = $(this).attr('for');
                var old_tags_name = $("#question_tag_field_" + a ).val();
                var old_tags_ids = $(".que_ids_added_" + a).val();
                var new_tag_id = $('.tag_id_box').val();
                if(old_tags_name){
                    var tag_names = old_tags_name + ',' + topic;
                    var tag_ids = old_tags_ids + ',' + new_tag_id;
                }
                else{
                    var tag_names = topic;
                    var tag_ids = new_tag_id;
                }
                $("#question_tag_field_" + a).val(tag_names);
                $(".que_ids_added_" + a).val(tag_ids);

            });
        },
        initialize_view_in_html_actions: function(){
            $('#_cpt_hide_answers').click(function(event){
                event.preventDefault();
                $('.answer_block_container').hide();
                $(this).hide();
                $('#_cpt_show_answers').show();
            });
            $('#_cpt_show_answers').click(function(event){
                event.preventDefault();
                $('.answer_block_container').show();
                $(this).hide();
                $('#_cpt_hide_answers').show();
            });
        },
        initialize_new_mock_events: function(){
            $("#mock_test_quesources").select2();
            $("#mock_test_quesources1").select2();
            $("#mock_test_quesources2").select2();
            $("#course").on("change", function(e){
                course_name = $(this).val();
                $.ajax({
                    url: '/mock_test/get_course_details',
                    dataType: 'json',
                    method: 'get',
                    data: { course_id: course_name
                    },
                    success: function(response){
                        $(".edit_subject").hide();
                        $(".subject_duration").html("");
                        html_data = '';
                        desc_html_data = '';
                        for (i in response['subject_name']){
                            html_data += "<div class='form-group'>";
                            html_data += "<div class='col-lg-8'>";

                            html_data += "<label class='col-sm-2 col-sm-2 control-label'>" + response['subject_name'][i] +" Duration</label>";
                            html_data += "<div class='col-sm-2'>";
                            html_data += "<input id='test_hour' class='form-control' type='text' name='" + response['subject_name'][i] + "_hours'>";
                            html_data += "</div>"
                            html_data += "<div class='col-sm-2'>";
                            html_data += "<input id='test_min' class='form-control' type='text' name='" + response['subject_name'][i] + "_minutes'>";
                            html_data += "</div>";
                            html_data += "</div>";
                            html_data += "</div>";
                            $(".subject_duration").html("");
                            $(".subject_duration").append(html_data);
                        }
                        //$(".subject_duration").html(html_data);
                        $(".subject_desc").html("");
                        for (i in response['subject_name']){
                            desc_html_data += "<div class='form-group'>";
                            desc_html_data += "<div class='col-lg-10'>";
                            desc_html_data += "<label class='col-sm-2 col-sm-2 control-label'>" + response['subject_name'][i] +" Description</label>";
                            desc_html_data += "<div class='col-sm-8'>";
                            desc_html_data += "<textarea class='form-control'  type='text' name='" + response['subject_name'][i] + "_description'></textarea>";
                            desc_html_data += "</div>";
                            desc_html_data += "</div>";
                            desc_html_data += "</div>";
                            $(".subject_desc").html("");
                            $(".subject_desc").append(desc_html_data);
                        }
                        $("#mock_test_test_category_id").html("");
                        $("#mock_test_test_category_id").html("");
                        $('#mock_test_test_category_id').append($('<option/>', {
                            value: "",
                            text : "Select category"
                        }));
                        for( i in response['product_name']) {
                            // alert(response['product_name'][i]);
                            $('#mock_test_test_category_id').append($('<option/>', {
                                value: response['product_id'][i],
                                text : response['product_name'][i]
                            }));
                        }
                    }
                });
            });
        },
        initialize_new_custom_mock_events: function(){
            $('form .courses').hide();
            $("#course").change(function(){
                $('form .courses').hide();
                var divClass = $('#course').val()
                $('#course_' + divClass).show();
            });
        },
        initialize_paragraph_new_ques: function(data){
            $(document).on('change', '#question_type', function(){
            var type = $('#question_type option:selected').val();
            if(type != '')
                $('#yes-add-question').attr('href', data + '?question_type='+type);
            });
        }
    }
})(jQuery);