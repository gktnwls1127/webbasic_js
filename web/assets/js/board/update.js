let initPage = () => {
    let temp = new URLSearchParams(window.location.search).get("id");
    let data;
    data = {"id": temp}

    $.ajax({
        url: "/board/printOne",
        method: "GET",
        data: data,
        success: (message) => {
            console.log(message);
            let result = JSON.parse(message);
            if (result.status == 'success') {
                let data = JSON.parse(result.data);
                printData(data);
            } else {
                console.log(data);
                Swal.fire({
                    title: "!!! ERROR !!!",
                    text: result.message,
                    icon: "error"
                }).then(() => {
                    location.href = result.nextPath;
                })
            }
        }
    });
}

function printData(data){
    $('#input-id').val(data.id + "번");
    $('#input-title').val(data.title);
    $('#editor').val(data.content);

    ClassicEditor.create(document.querySelector('#editor')).catch(error => {
        console.log(error)
    }); // ckeditor 를 초기화하기 전에 데이터를 넣고 초기화를 진행

}

let updateBoard = () => {
    let id = $('#input-id').val().replace("번", "");
    let formData = {
        id : id,
        title :  $('#input-title').val(),
        content : $('.ck-editor__editable').html(),
    }

    $.ajax({
        url : "/board/update",
        method: "post",
        data : formData,
        success : (response) => {
            let result = JSON.parse(response);
            Swal.fire({
                icon : result.status,
                text : result.message
            }).then(()=>{
                location.href = result.nextPath;
            })
        }
    })

}