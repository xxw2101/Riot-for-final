
<app>
  <h2>My TO Do List</h2>
  <div class="wrap">
    <div class="items">
      <todoItem each = {i in todoItems}></todoItem>
    </div>
    <input type="text" onkeypress={typeWords} placeholder="type in your to do item" class="textInput">
    <button class="delete" onclick={delete}>Delete {todoItems.filter(cal).length} </button>
  </div>
  <script>
    var that = this;
    this.todoItems = [];

    var database = firebase.database();
    var todoRef = database.ref('todoitem');


    //listen to value events in firebase
    // todoRef.on('value', function(value) {
    //   var data = value.val();
    //   var todos = [];

    //   for (var key in data) {
    //     todos.push(data[key])

    //   }
    //   that.todoItems = todos
    //   that.update();
    // })


    // listen to child_added event in firebase
    todoRef.on('child_added', function(value) {
      var data = value.val();
      var id = value.key;
      data.id = id;
      that.todoItems.push(data)
      that.update();
    })
    todoRef.on('child_removed', function(value) {
      var data = value.val();
      var id = value.key;

      var target;
      for(let i = 0; i < that.todoItems.length; i++) {
        if(that.todoItems[i].id === id) {
          target = that.todoItems[i];
          break
        }
      }
      var index = that.todoItems.indexOf(target);
      that.todoItems.splice(index, 1);

      that.update();
    })



    this.typeWords = function(event) {
      var newTask = {};
      var words = event.target.value;
      if(event.which == 13) {
        newTask.name = words;
        newTask.done = false;
        // that.todoItems.push(newTask);
        event.target.value = '';

        var newID = todoRef.push().key;
        todoRef.child(newID).set(newTask);
      }
    }



//delete the finished items
    this.delete = function() {

      var deleted = this.todoItems.filter(function(item){
        return (item.done === true)
      })

      deleted.forEach(function(item){
        var rfKey = item.id;
        todoRef.child(rfKey).remove();
      })


      // this.todoItems = this.todoItems.filter(function(item) {
      //   if(item.done === true) {
      //     idDelete.push(item.id);
      //   }
      //   return(item.done === false)
      // })

      // console.log(todoRef)


    }


// calculate how many items checked in the list
    this.cal = function(item) {
        return(item.done === true)
    }


  </script>

  <style>
    button:focus {outline:0;}

    h2 {
      text-transform: uppercase;
      padding: 20px;
      font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    }

    .wrap {
      max-width: 300px;
      width: 60%;
      margin: 0 auto;
      margin-top: 10%;
      box-sizing: border-box;
    }
    .items {
      display: block;
    }

    .textInput {
      display: block;
      width: 100%;
      padding: 6px 12px;
      font-size: 14px;
      line-height: 1.42857143;
      color: #555;
      background-color: #fff;
      background-image: none;
      border: 1px solid #ccc;
      border-radius: 4px;
      -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
      box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
      -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
    }

    .delete {
      margin: 10px;
      height: 30px;
      border: 1px solid #ccc;
      border-radius: 4px;
      background: transparent;
      cursor: pointer;
      color: #222;
      transition: all .4s;
      padding: 20px 30px;
      line-height: 0px;
      font-size: 16px;
      text-transform: uppercase;
    }

    .delete:hover {
      background: #222;
      color: #fff;
    }
  </style>
</app>
