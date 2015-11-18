function datafilePreviewer(previewer){

  function markForDelete(){
    cleaner.hide();
    clear.val("1")
    field.val("");
    mask.val("");
  }

  var cleaner = previewer.find(".datafile-preview-clear");
  var clear   = previewer.find("input:hidden")
  var field   = previewer.find("input:file")
  var mask    = previewer.find("input:text")

  cleaner.on("click", function(){
    markForDelete();
  })

  field.on("change", function(){
    var file = this.files[0];
    cleaner.show();
    clear.removeAttr("value");
    mask.val(file.name);
  })
}

function imagePreviewer(previewer){

  function markForDelete(){
    cleaner.hide();
    clear.val("1")
    img.attr("src", previewer.attr("data-missing"));
    mask.val("");
    wrapper.popover("hide");
    field.val("");
  }

  var img = $("<img />", {
    src: previewer.attr("data-src"),
    width: 200
  })

  var wrapper = previewer.popover({
    content: img,
    html: true,
    placement: "top",
    title: "Vista previa",
    trigger: "hover"
  })

  var cleaner = previewer.find(".image-preview-clear");
  var clear   = previewer.find("input[type=hidden]")
  var field   = previewer.find("input[type=file]")
  var mask    = previewer.find("input[type=text]")

  img.error(function() {
    dummy = $("<img />", { src: previewer.attr("data-missing") });
    dummy.load(function(){
      markForDelete();
    })
  })

  cleaner.on("click", function(){
    markForDelete();
  })

  field.on("change", function(){
    var file = this.files[0];
    var reader = new FileReader();

    reader.onload = function (e) {
        cleaner.show();
        clear.removeAttr("value");
        img.attr("src", e.target.result);
        mask.val(file.name);
        wrapper.popover("show");
    }
    reader.readAsDataURL(file);
  })
}
