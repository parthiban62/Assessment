$(document).ready(function(){
	$(".draggable").draggable();
	$(".dropzone-container" ).droppable({
	    drop: function( event, ui ) {
	        $.ajax({
	            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
	            url: '/surveys/<%= @survey.id%>/add_questions',
	            method: 'post',
	            data: {question_id: $(ui.draggable).attr("id")},
	            success: function(response){

	            }
	        });
	    }
	});
});

function add_fields(link){
	var regexp, time;
	time = new Date().getTime();
	regexp = new RegExp($(link).data('id'), 'g');
	$(link).before($(link).data('fields').replace(regexp, time));
	return event.preventDefault();
}
function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest('.fields').hide();
  return event.preventDefault();
}

function toggleContainer(){
    $(".questionForm").toggle();
    $(".dragDropQuestion").toggle();
}
function openPopup(){
    $("form#new_question")[0].reset();
    $("#myModal").modal();
}