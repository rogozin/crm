// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require adapt/config
//= require adapt/adapt
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require tinymce-jquery
//= require_tree .


  $(function() {
    $('input.datepicker').datepicker($.datepicker.regional['ru']);
    $('.tinymce textarea').tinymce({
      theme: 'advanced',
      theme_advanced_toolbar_location : "top",
       theme_advanced_toolbar_align : "left",
       theme_advanced_statusbar_location : "bottom",
        theme_advanced_resizing : true,
        theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,sub,sup,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,fontselect,fontsizeselect",
       theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,anchor,image,cleanup,code,|,forecolor,backcolor|,hr,|,charmap",
       theme_advanced_buttons3 : ""
    });
  });
