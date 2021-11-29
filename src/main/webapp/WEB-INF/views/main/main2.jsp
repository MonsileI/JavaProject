<!DOCTYPE html>
<html>
    <head>
    
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" 
        integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" 
        crossorigin="anonymous">

         <script>

         var myModal = null;
         
         //===============변수의 생성시점 맞추기위해서
         //아래처럼 변수 선언 하지말것 ->
         //1.onload=init()시에 한번 실행 or 
         //2.window.addEventListener('DOMContentLoaded', init);(더 일반적인 방법)
         //var myModal = new bootstrap.Modal(document.getElementById('testModal'));
          
         
         function testModal(){
        	 
        	 myModal.show();
          }
          
         function closeModal(){
        	 
        	 myModal.hide();
          }
         
        /* 
        ex.
        자바에서도 interface를 활용하여 callback 함수호출은 가능하나 복잡 
        
        //호출하고 리턴 값을 저장 
        var aa = init(); 
        
        //함수 자체를 넘김
        var a = init;
        //호출 
        a();
        */
			
       function init(){
        	myModal = new bootstrap.Modal(document.getElementById('testModal'));
        } 
        // callback 함수 
        window.addEventListener('DOMContentLoaded', init);
        
        </script>

    </head>
    <body>
    
    
  <button onclick="testModal()" class="btn btn-primary">야호</button>

  <!-- Modal -->
  <div class="modal fade" id="testModal" tabindex="-1" aria-labelledby="testModalLabel" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="testModalLabel">Modal title</h5>






          <button type="button" 
	          class="btn-close" 
	          id="" data-bs-dismiss="modal" 
	          aria-label="Close"></button>
        </div>
        
        <div class="modal-body">
                    
          <button onclick="closeModal()"></button>
          
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
          <button type="button" class="btn btn-primary">Save changes</button>
        </div>
      </div>
    </div>
  </div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" 
        integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" 
        crossorigin="anonymous"></script>
        
 
 
    </body>
</html>



