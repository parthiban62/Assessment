function add_fields(link){
	var regexp, time;
	time = new Date().getTime();
	regexp = new RegExp($(link).data('id'), 'g');
	$(link).before($(link).data('fields').replace(regexp, time));
	return event.preventDefault();
}

function remove_fields(link) {
  $(link).prev().prev().removeAttr("required");
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest('.fields').hide();
  return event.preventDefault();
}

function toggleContainer(){
	dragdrop();
    $(".questionForm").toggle();
    $(".dragDropQuestion").toggle();
}

function openPopup(){
    $("form#new_question")[0].reset();
    $("#myModal").modal();
}

function dragdrop(){
	var existing_items = $.map($(".dropzone-container p"), function(n, i){ return n.id;});
	$('.draggable').draggable({
	  revert: function() {
	    if ($(this).hasClass('drag-revert')) {
	      $(this).removeClass('drag-revert');
	      return true;
	    }
	  }
	});
	$(".dropzone-container" ).droppable({
	    drop: function( event, ui ) {
	    	if(existing_items.includes($(ui.draggable).attr("id"))){
	    		alert("Question already exists in the survey");
	    		return $(ui.draggable).addClass('drag-revert');
	    	}
	    	else{
	    		var survey_id = $("#survey_id_details").val();
		        $.ajax({
		            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		            url: "/surveys/"+survey_id+"/add_questions",
		            method: 'post',
		            data: {question_id: $(ui.draggable).attr("id")},
		            success: function(response){
		            }
		        });
		        $(ui.draggable).removeClass('draggable');
		        var ele = $(ui.draggable).detach()
		        $(ele).removeAttr("class").removeAttr("style")
		        $(".dropzone-container").append(ele);
	    	}
	    }
	});
}

function showLoader(){
	$(".ajax-loader").show();
}

function hideLoader(){
	$(".ajax-loader").hide();
}

function confirmResponse(){
	$(".SurveyResponseConfirmation").modal();
}

function SubmitResponse(){
	$(".close-popup").click();
	$(".response-submit").attr("disabled", true)
	$("form.response_survey_form").submit();
}