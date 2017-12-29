### Comment delete & edit 

---

#### delete

```javascript
//show.html.erb
<script>

$(function(){
  // 댓글 삭제
  // 1. 댓글에 있는 '삭제'버튼을 누르면
  // $('.destroy-comment').on('click',function(){
  $(document).on('click','.destroy-comment',function(){
    console.log($(this));
    var id = $(this).data('id');
    console.log(id);
    if(confirm("R U SURE?")){
          // 2. 해당 댓글에 대한 삭제 요청을 서버로 보내고
    $.ajax({
      url: `/boards/<%=@board.id%>/comments/${id}`,    //`${}` javascript에서는 ``이걸로 씀 ""대신 `는 물결표시있는데
      method: 'delete'
    })
    // 3. 서버에 있는 DB에서 삭제한 이후에
    // 4. 해당 HTML Element를 삭제한다
  }
  })
})
</script>
```



$('.destroy-comment').on('click',function(){}

이걸 이용하면 document(페이지?)를 이미 한번 받은 상태에서 새로 javascript로 element를 추가하면 document 자체가 업데이트 되는게 아니라 이미 기존에 날아와있던 document listener가 달린거고 새로 추가되는 애들은 반영이 안됨.

그래서

$(document).on('click','.destroy-comment',function(){}

이렇게 바꿔줘야함.

그러면 새로 추가되는 element들도 반영됨.

예를 들면 댓글을 수정 할 때  destroy_comment.js.erb에서  comment를 지우거나 create_comment.js.erb에서 테이블을 추가해주면 show에서 해주는게 아니라 reload 안해주면 추가된 element들이 반영된 화면을 볼 수 없음



```ruby
#boards_controller.rb  
def destroy_comment
  @comment = Comment.find(params[:comment_id]).destroy
    # puts "#{params[:comment_id]}번 delete"
  end
```

comment_id는 테이블에서 td에서 data-id를 comment.id로 설정해서 넘겨준 값.

```javascript
//삭제한 댓글에 해당하는 tr부분을 찾아 화면에서 지워줌
$('#comment-<%=@comment.id%>').hide().remove();  //hide 안보이게 하는거. remove 지우는거
alert("deleted");

```

hide는 그냥 안보이게 숨기기만 하고 remove는 화면에서 지우는거.

---

#### edit

```javascript
// 댓글 수정
  // 1. 수정 버튼을 누르면
  $(document).on('click', '.edit-comment',function(){
    var comment = $($(this).parent().siblings()[0]);
    //console에서 확인해보면 됨. comment 구조 확인해서 찾으면됨.
    //innerText, textContent, innerHTML......
    var td = $(this).parents('.comment-list').find('.edit-comment-form');
    
    if(td.length > 0){ //edit을 여러개 누르면 닫아주는 역할
      alert("other input window is opening!!!!!!!!!!!!!!!!");
      return false;
      td.each(function(){
        $($(this).parent().siblings()[0]).replaceWith(`<td align="center">
            <button type="button" class ="btn btn-warning edit-comment" data-id="${id}" >edit</button>
      </td>`);
        $.ajax({
          url: `/boards/<%=@board.id%>/comments/${id}`,
          //`${}` javascript에서는 ``이걸로 씀 ""대신 `는 물결표시있는데
          method: 'put',
          data: {contents: q}
        }) //ajax
        $(this).replaceWith($(this).val());
      })//td.each
    }//if
    
    var q = comment[0].textContent;  //td에 포함된 text가져오는거 
    var id=$(this).data('id');
    comment.replaceWith(`<td><input type="text" value="${q}"
    class="form-control edit-comment-form" />
      </td>`);
      // 3. 수정버튼은 완료버튼으로 바꿔주고
      //button만 바꾸는거라 <td>가 없음
      $(this).replaceWith(`<button type="button" class ="btn btn-warning update-comment" data-id="${id}">
      done</button>`)
  })


//update 
  $(document).on('click','.update-comment',function(){ 
  // console.log($($(this).parent().siblings()[0]);
  var q = $('.edit-comment-form').val();
  var id=$(this).data('id');

  //ruby태그는 #{}최초 1회만 만들어짐? 사용됨?
  // 4. 완료버튼을 누르면 input 태그를 다시 td태그로 바꾸고
  $($(this).parent().siblings()[0]).replaceWith(`<td>${q}</td>`);
  $(this).replaceWith(`<button type="button" class ="btn btn-warning edit-comment"
   data-id="${id}" >edit</button>`);

   // 5. 해당 내용을 서버로 전송합니다
   $.ajax({
     url: `/boards/<%=@board.id%>/comments/${id}`,    //`${}` javascript에서는 ``이걸로 씀 ""대신 `는 물결표시있는데
     method: 'put',
     data: {contents: q}
   })
})
```



`$($(this).parent().siblings()[0])`

이거는  지금 선택된 객체의 부모 객체. 그러니깐 버튼을 눌렀을 때 작동된 함수면 버튼의 parent 즉, 버튼이 속한 <td>태그를 가리키고 siblings는 형제. 해당 <td>태그랑 같은 depth를 가지는, 같은 <tr>에 속해 있는 <td>들을 가져오는데 그 중에 0번째니깐 처음에 있는 <td>. 그걸 $()로 묶었으니깐 jQuery형태로 가져옴.

id를 가져올 때 테이블에서 each 문 안에 comment를 가져올 수 없기 때문에`var id=$(this).data('id');` 이런 식으로 지정되어 있는 id를 가져옴.

edit버튼을 누르면 버튼 명을 done으로 바꿔주는 부분도 넣어줌.

update부분에서 보면 ajax를 통해서 서버로 전달.

url, method, data를 보내줌. 

```ruby
#routes.rb
  put '/boards/:id/comments/:comment_id' => 'boards#update_comment'
```

```ruby
#boards_controller.rb
def update_comment
    @comment=Comment.find(params[:comment_id])
    @comment.update(contents: params[:contents])
  end
```

views-boards-update_comment.js.erb를 만들어서 alert("comment edited"); 추가해줌. controller에서 연결되는 부분이 필요해서? 없어도 되나???



if문 부분은 edit이 한개이상 선택되면 다 닫아주는 역할.  다 닫고 그 아래에서 선택된 애만 열어줌. 

```javascript
 var q = comment[0].textContent;  //td에 포함된 text가져오는거 
    var id=$(this).data('id');
    comment.replaceWith(`<td><input type="text" value="${q}"
    class="form-control edit-comment-form" />
      </td>`);
      // 3. 수정버튼은 완료버튼으로 바꿔주고
      //button만 바꾸는거라 <td>가 없음
      $(this).replaceWith(`<button type="button" class ="btn btn-warning update-comment" data-id="${id}">
      done</button>`)
```

이부분이 다시 열어주는 부분