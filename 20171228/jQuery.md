### jQuery

자바스크립트의 생산성을 향상시켜주는 자바스크립트 라이브러리

---

#### css selector

$가 jQuery를 의미. tag

class이름으로 선택할 떄

- $('.className') ==document.getElementsByClassName
- $('#id') == document.getElementById
- $('HTMLtag') ==document.getElementsByTagName

```javascript
// document가 다 날아온 이후에 실행한다는걸 보장해줘야함
  $(document).ready(function(){//document가 준비되면 함수를 실행
  });
//혹은 
  $(function){}
```

---

##### mouse event

```javascript
  $(document).ready(function(){
    // 1. 마우스 오버를 하면
    // 1-1. 버튼을 찾아서 오버이벤트 달기
      $('.color-btn').on('mouseover',function(){
        //on다음에 나오는게 event
        //console.log("mose over");
        console.log($(this).attr("data-s")); //속성을 가져올 수 있음
        console.log($(this).data("s")); //jQuery에서는 data- 가 있으면 뒤에 붙은걸 가져올 수 있음  data-s="text-primary"
        // $로 안감싸 주면 jQuery문법을 사용 못함. jQuery객체로 만들어주는거
        // $(this).toggleClass("text-danger");
        var tStyle=$(this).data("s");
        // 2. table 전체에 (table을 찾아서)
        // 3. 글자 색을 바꿔주는 class를 넣는다
        $('.table').toggleClass(tStyle);
      });

      $('.color-btn').on('mouseout',function(){//mouseleave로 해도 됨
        var textStyle=$(this).data("s");
        $('.table').toggleClass(textStyle);
      });
  });
```



- click : 마우스를 클릭할 때 발생
- dbclick : 마우스를 더블 클릭할 때 발생
- mousedown : 마우스 버튼을 누를 때 발생
- mouseup : 마우스 버튼을 뗄 때 발생
- mouseenter : 마우스가 요소의 경계 외부에서 내부로 이동할 때 발생
- mouseleave : 마우스가 요소의 경계 내부에서 외부로 이동할 때 발생
- mousemove : 마우스를 움직일 때 발생
- mouseout : 마우스가 요소를 벗어날 때 발생
- mouseover : 마우스를 요소 안에 들어올 때 발생



---

#### Like 기능

board는 여러개의 likes를 가질 수 있고

like는 여러명의 user랑 연결됨

board – 1:n - like –n:1 – user

| board | <-> 1:n <-> | like | <->n:1<-> | user |
| ----- | ----------- | ---- | --------- | ---- |
| post1 |             | 4    |           | 4    |
| post2 |             | 5    |           | 5    |

유저 한명은 여러 글에 하나씩 like를 하니깐 여러 like를 글id랑 가지고 있음

```ruby
#db-migrate-create_likes.rb
      t.integer :board_id
      t.integer :user_id
```

```ruby
#board.rb 
  belongs_to :user
  has_many :likes
```

```ruby
#user.rb
  has_many :boards
  has_many :likes
```

```ruby
#like.rb
  belongs_to :user
  belongs_to :board
```

```ruby
#boards_controller.rb
	def like_board
    user_like = Like.where(user_id: current_user.id, board_id: params[:id])
    if user_like.count>0
      #find랑 where차이는 find는 한개만 return. where는 배열로 여러개 리턴
      user_like[0].destroy
      #user_like.first.destroy
    else
      Like.create(user_id: current_user.id, board_id: params[:id])
    end
    @like=Board.find(params[:id]).likes.count #count는 메소드
  end
```

```javascript
//show.html.erb
<%if @like.count > 0 %>
<!--좋아요가 이미 눌려있을 때-->
<button type="button" class ="btn btn-danger" id="like">
  <i class="fas fa-american-sign-language-interpreting fa-3x fa-spin ">
  </i> I likeeeeee it!!!!(<span id="like-counter"><%=@board.likes.count%></span>)
</button>
<!-- <a href="/" class ="like"></a> -->
<%else%>
<!--좋아요를 새로 눌렀을 때-->

<button type="button" class ="btn btn-info" id="like">
  <i class="fas fa-american-sign-language-interpreting fa-3x fa-spin "></i> I likeeeeee it!!!!(<span id="like-counter">0</span>)
</button>
<%end%>
  
  
<script>
$(function(){
 	 // 1. 좋아요 버튼을 클릭하면
    // 2. 버튼의 색깔을 빨강으로 바꾸고
    // 3. 좋아요 카운트를 1 증가시킨다.
    $('#like').on('click',function(){
        $.ajax({
          url: '/boards/<%=@board.id%>/like',
          method: 'POST'
        });
    console.log(this.classList.contains('btn-info')); //javascript에 있는애 classList
    // if $(this).attr("calss")=="btn-info"
    if (this.classList.contains('btn-info')){
    $('#like-counter').html(parseInt($('#like-counter').html())+1);
      //parseInt는 integer로 변환 시켜주는거. 
    }
    else{
      $('#like-counter').html(parseInt($('#like-counter').html())-1);
    }
    // $(this).toggleClass('btn-danger').toggleClass('btn-info');
    // $("셀렉터").html()
    // 셀렉터태그내에 존재하는 자식태그을 통째로 읽어올때 사용되는 함수
    // ※ 태그 동적추가할때 주로 사용되는 함수
    //
    // $("셀렉터").text()
    // 셀렉터태그내에 존재하는 자식태그들 중에 html태그는 모두 제외 한 채 문자열만 출력하고자 할때 사용되는 함수
    // ※ html태그까지 모두 문자로 인식시켜주는 함수
  })

})
  // 4.빨간색으로 변한 버튼을 누르면
  // 5. 다시 파랑으로 바꾸고
  // 6. 좋아요 카운트를 1 감소시킨다.

</script>
```

`$.ajax({});`는  ajax 문법. 보내는 주소와, 방법을 넣어줌. 필요하면 data도 넣어줌. 이건 comment에서 다시 언급.

```javascript
//views-boards-like-board.js.erb
$('#like').toggleClass('btn-danger').toggleClass('btn-info');
$('#like-counter').text(<%=@like%>);
```

@like는 controller에서 count해서 넘어온 like 수 

  ```ruby
#routes.rb
post '/boards/:id/like' => 'boards#like_board'
  ```





---

$는 jQuery라는 의미

##### css selector review

​	class는 .class

​	id는 #id

​	 $$('button')   tag  $한개 지워야함

​	$('.button')   class

​	$('#button')  id

`<button type="button" class ="btn btn-info" id="like"> `

$('#like')

---

#### comment 기능

```ruby
#db-migrate-create_comment.rb
      t.text :contents
      t.integer :user_id
      t.integer :board_id
```

```ruby
#models-comment.rb
  belongs_to :user
  belongs_to :board
```

```ruby
#models-user.rb
  has_many :boards
  has_many :likes
  has_many :comments
```

```ruby
#models-board.rb
  belongs_to :user
  has_many :likes
  has_many :comments
```

```html
<!--show.html.erb-->
<form id ="comment-form" class="form-inline">
  <input type="text" class = "form-control col-9 mb-2 mr-sm-2 mb-sm-0" id="comment">
  <button type="submit" class ="btn btn-warning create-comment">commenttttt</button>
</form>

<table>
  <tbody class ="comment-list">
  <%@board.comments.reverse.each do |comment|%>
    <tr>
      <td>
        <%=comment.contents%>
      </td>
      <td><a href ="/boards/<%=@board.id%>/destroy_comment">delete</a></td>
      <td><a href ="/boards/<%=@board.id%>/edit_comment">edit</a></td>
    </tr>
    <% end %>
  </tbody>
</table>
```

```javascript
//<!--show.html.erb-->
<script>
  $(function(){
  // 1. 댓글 달기 버튼을 누르면
  // 1-1. 댓글 form이 submit되면
  $('#comment-form').on('submit',function(event){
    event.preventDefault();
    console.log("clicked");
    // 2. input 안에 들어있는 내용을 찾아서
    var c = $('#comment').val();//id="comment"에 들어있는 value
    console.log(c);
    $.ajax({
      url: "/boards/<%=@board.id%>/create_comment", method: "POST", data: { contents: c}//inputname: value
    });
  });
  // 3. 서버에 보내준다.
  // 4. 작성한 내용을 input 아래에 추가해준다
});
</script>
```

`$.ajax` data:{}는 create하는 방법이랑 비슷하게 넣어줌. 그러면 넘어감.



```ruby
#boards_controller.rb
  def create_comment
    # 넘어오는 :contents는     $.ajax({
    #url: "/boards/<%=@board.id%>/create_comment", method: "POST", data: { contents: c}//inputname: value
        #});
    @comment=Comment.create(contents: params[:contents],user_id: current_user.id, board_id: params[:id])
  end
```

```javascript
//views-boards-create_comment.js.erb
$('.comment-list').prepend('<tr><td><%=@comment.contents%></td></tr>');
$('#comment').val('');

```

prepend는 append랑 비슷한데 역순으로 붙음.

얘는 화면이 reload 안돼도 자동으로 들어가게 해주는거. 강제로 삽입

show에서 each do 돌려 주는건 새로 화면을 받아왔을 때 출력.



```ruby
#routes.rb
  post '/boards/:id/create_comment' => 'boards#create_comment'
```

---

#### AJAX

 자바스크립트로 비동기 요청을 보내 서버 로직을 실행하고 응답으로 자바스크립트를 실행해서 HTML Document의 일부분만 고치는 방법

한 부분만 바꿔주는걸 AJAX라고 함. 

서버에 부하도 줄여줌. 응답을 간단하게 줌.

요청을 보내는데 우리가 서버에다가 뷰를 누르면 전체가 바뀌는데 한부분만 바뀌면 될 때(버튼 이벤트 같은거.) 동작 하나만 하면 될 떄 응답으로 자바스크립트코드를 하나를 넘겨줌.

comment에서 화면 reload안되고 ajax로 새 댓글만 끼워 넣는거 

태그들 하나하나를 DOM으로 보면 됨

