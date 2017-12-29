// 제목 바꾸기
// 1. 버튼을 클릭
// 1-1. 버튼에 해당하는 HTML element를 찾는다
// var btn = document.getElementsByTagName('button')[1];
// console.log(btn);
// btn.onclick=function(){//익명 함수
// // alert("btn clicked");
// var answer = prompt("Chane title?");
// console.log(answer);
// var titles = document.getElementsByClassName('title');
// for(var i=0; i<titles.length; i++){
//   titles[i].textContent = answer;
// }
// alert("Title changed");
// }


// document가 다 날아온 이후에 실행한다는걸 보장해줘야함
$(document).ready(function(){//document가 준비되면 함수를 실행
    //1. 버튼을 클릭하면
    // 1-1.버튼을 찾아서
      var btn = $('.change-title');
      console.log(btn);// jQuery 형식
      console.log(btn[0]); //element 그 자체
    // 1-2. 클릭 이벤트 리스너를 달아준다.
    btn.on('click',function(){   //내가 사용할 수 있는걸로 알아서 찾아줌
      // alert("clicked!");
      // 2. title에 해당하는 부분을 찾아서
      var str=prompt("wona title:");
      // 3. 내가 입력한 문자열로 바꿔준다.
      $('.title').text(str);
    })
});  // $(function(){}) 이렇게 쓸 수도 있음.

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
// css selector
// class .class
// id #id
// $('button')   $가 jQuery를 의미
// $('.button')
// $('#button')
