// 제목 바꾸기
// 1. 버튼을 클릭
// 1-1. 버튼에 해당하는 HTML element를 찾는다
var btn = document.getElementsByTagName('button')[1];
console.log(btn);
btn.onclick=function(){//익명 함수
// alert("btn clicked");
var answer = prompt("Chane title?");
console.log(answer);
var titles = document.getElementsByClassName('title');
for(var i=0; i<titles.length; i++){
  titles[i].textContent = answer;
}
alert("Title changed");
}
// 함수를 선언하는 방법
// 1.
// var fn1=function(){
//
// }
// 2.
// function fn2(){
//
// }
// 1-2. 해당 element에 click 이벤트 리스너를 달아준다
// 2. index에서 제목에 해당하는 부분을 찾아
// 3. 사용자가 입력한 텍스트로 모두 바꿔줌
//
