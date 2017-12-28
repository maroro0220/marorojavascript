//버튼에 마우스 오버하는 것에 따라서 텍스트 색깔 제목바꾸기
// 1. 버튼을 마우스 오버 할 때
// 1-1. 버튼 찾기(className, color-btn)
// 1-2. 버튼을 순환하면서 이벤트 리스너를 달아준다.
// 2. table에 해당하는 HTML element를 찾아서

// 3. color: red/blue/green의 속성을 부여한다

//해결방법
//1. 각 버튼에 있는 클래스에 따라서 다른 클래스를 부여한다. (조건문)
// for(var i=0;i<buttons.length;i++){
// // var btn = buttons[i];
//   buttons[i].onmouseover=function(){
//     var table = document.getElementsByTagName('table');
//
//     table[0].classList.add('text-success');
//     // console.log(this.classList);
//     // console.log(btn.classList);
//     console.log("class yopyopyop");
//   }
// }

//2. 각 버튼에 각각 다른 이벤트 핸들러를 설정한다.
var buttons=document.getElementsByClassName('color-btn');
buttons[0].onmouseover = function(){
  setTableAttribute('table table-hover text-danger');
}
buttons[1].onmouseover = function(){
  setTableAttribute('table table-hover text-primary');
}
buttons[2].onmouseover = function(){
  setTableAttribute('table table-hover text-success');
}
var setTableAttribute = function(classList){
  var table = document.getElementsByTagName('table')[0];
    table.setAttribute('class',classList);
}
