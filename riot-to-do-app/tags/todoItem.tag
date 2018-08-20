
<todoItem>
  <label class={complete: i.done}>
    <input type="checkbox" checked={i.done} onclick={toggle}>{i.name}
  </label>


  <script>
    this.toggle = function(event) {
      // console.log(event.item);   //This step is really important
      event.item.i.done = !event.item.i.done;
      this.parent.update();
    }

  </script>



  <style>
    label {
      display: block;
      padding: 8px 10px;
      cursor: pointer;
      font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
    }

    .complete {
      text-decoration: line-through;
      color: #aaa;
    }
  </style>

</todoItem>
