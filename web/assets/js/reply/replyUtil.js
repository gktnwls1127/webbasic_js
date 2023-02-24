let writeReply = () => {
    let formData = {
        "content": $('#input-reply').val(),
        "boardId": new URLSearchParams(window.location.search).get("id")
    }
    $.ajax({
        url: "/reply/write",
        method: "post",
        data: formData,
        success: (message) => {
            let response = JSON.parse(message);
            if (response.status == "fail") {
                Swal.fire({
                    title: "!!! ERROR !!!",
                    text: "에러가 발생하였습니다.",
                    icon: "error"
                })
            }
            location.reload();
        }
    })
}

function printReply(boardId) {
    let sendData = {
        "boardId": boardId
    }
    $.ajax({
        url: "/reply/selectAll",
        method: "get",
        data: sendData,
        success: (message) => {
            let response = JSON.parse(message);
            let replyArray = JSON.parse(response.list);
            printList(replyArray);
        }
    })
}

function printList(replyArray) {

    if (replyArray.length == 0) {
        $('#tbody-reply').append(
            $(document.createElement("tr")).append(
                $(document.createElement("td")).attr("colspan", "2").text("아직 등록된 댓글이 존재하지 않습니다.")
            ));
    } else {
        replyArray.forEach(reply => {
                let tr = $(document.createElement("tr"));
                let td = $(document.createElement("td")).attr("colspan", "2")
                let str = reply.writer + " : " + reply.content + " at " + reply.date;
                $(td).text(str);
                if (reply.isOwned == true){
                    let btnUpdate = $(document.createElement("div")).addClass("btn btn-success").text("수정");
                    btnUpdate.click(() => {
                        updateUi(td, reply);
                    })
                    let btnDelete = $(document.createElement("div")).addClass("btn btn-danger").text("삭제");
                    btnDelete.click(() => {
                        deleteReply(reply.id);
                    })
                    $(td).append(btnUpdate);
                    $(td).append(btnDelete);
                }

                $(tr).append(td);
                $('#tbody-reply').append(tr)
            }
        );
    }

}

function deleteReply(id){
    let sendData = {
        "id" : id,
    }
    $.ajax({
        url : "/reply/delete",
        method : "get",
        data : sendData,
        success : (message) => {
            let response = JSON.parse(message);
            if (response.status == 'fail'){
                Swal.fire({text : "오류가 발생하였습니다.",title: "!!! ERROR !!!" });
            }
            location.reload();
        }
    })
}

function updateUi(td, reply){
    let tr = $(td).parent();
    $(tr).html("");

    let form =
        $(document.createElement("input"))
        .attr("type", "text").addClass("form-control")
        .val(reply.content).attr("id", "input-update" + reply.id);
    let btnUpdate =
        $(document.createElement("div")).addClass("btn btn-success w-25").click(updateReply(reply));
    let newTd = $(document.createElement("td")).attr("colspan", "2").append(form).append(btnUpdate);

    $(tr).append(newTd);
}

function updateReply(reply){
    let content = $('#input-update' + reply.id).val();
    let formData = {
        "content" : content,
        "id" : reply.id
    }
    $.ajax({
        url : "/reply/update",
        method : "post",
        data : formData,
        success : (message) => {
            let response = JSON.parse(message);
            if (response.status == 'fail'){
                Swal.fire({text : "오류가 발생하였습니다.",title: "!!! ERROR !!!" });
            }
            location.reload();
        }
    })
}