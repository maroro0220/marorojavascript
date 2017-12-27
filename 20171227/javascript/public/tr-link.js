// table의 한 줄을 클릭했을 경우에 해당 글의 show 페이지로 이동
// 1. table의 각 줄을 찾는다.
var boards=document.getElementsByClassName('board');
// 2. 각 줄을 순회하며 이벤트 리스너를 달아준다.
for(var i=0;i<boards.length;i++){
  boards[i].addEventListener('click',function(){
  var id= this.getAttribute('data-value');//속성명(data-value)에 들어있는 속성값(board.id)이 return됨
  //eventhandler는 이벤트가 발생됐을 떄 실행되는 함수??
  console.log(id);
  location.href="/boards/"+id;
})
}
// 3. 해당 줄이 몇번째 글인지 파악한다(id 파악)
// 4. 파악한 id에 해당하는 글로 이동한다.
