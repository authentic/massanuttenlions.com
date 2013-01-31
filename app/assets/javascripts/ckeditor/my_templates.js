/*
 Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */
CKEDITOR.addTemplates("my_templates", {imagesPath:CKEDITOR.getUrl("/assets/ckeditor/image_template/"), templates:[
    {title:"Image and Title",
        image:"template1.gif",
        description:"One main image (on the left) with a title and text that surround the image.",
        html:'<h4><img style="margin-right: 15px" height="100" width="100" align="left"/>Type the title here</h4><p>Type the text here</p>'},
    {title:"Image and Title",
        image:"template4.gif",
        description:"One main image (on the right) with a title and text that surround the image.",
        html:'<h4><img style="margin-left: 15px" height="100" width="100" align="right"/>Type the title here</h4><p>Type the text here</p>'},
    {title:"Strange Template",
        image:"template2.gif",
        description:"A template that defines two colums, each one with a title, and some text.",
        html:'<table cellspacing="0" cellpadding="0" style="width:100%" border="0"><tr><td style="width:50%"><h4>Title 1</h4></td><td></td><td style="width:50%"><h4>Title 2</h4></td></tr><tr><td>Text 1</td><td></td><td>Text 2</td></tr></table><p>More text goes here.</p>'},
    {title:"Text and Table",
        image:"template3.gif",
        description:"A title with some text and a table.",
        html:'<div style="width: 80%"><h4>Title goes here</h4><table style="width:150px;float: right" cellspacing="0" cellpadding="0" border="1"><caption style="border:solid 1px black"><strong>Table title</strong></caption></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr><tr><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr></table><p>Type the text here</p></div>'},
    {title:"Image with description and Title",
        image:"template5.gif",
        description:"One main image (on the right) with a title and text that surround the image",
        html:' <table style="float: right;"><tbody><tr><td><img height="150" width="250" align="center" style="margin-left: 15px;" alt="" /></td></tr><tr><td><div class="img_description center"><small><i>Type the description here</i></small></div></td></tr></tbody></table><h4>Type the title here</h4><p>Type the text here</p><div class="clearfix">&nbsp;</div>'},
    {title:"Image with description and Title",
        image:"template6.gif",
        description:"One main image (on the left) with a title and text that surround the image",
        html:' <table style="float: left;"><tbody><tr><td><img height="150" width="250" align="center" style="margin-right: 15px;" alt="" /></td></tr><tr><td><div class="img_description center"><small><i>Type the description here</i></small></div></td></tr></tbody></table><h4>Type the title here</h4><p>Type the text here</p><div class="clearfix">&nbsp;</div>'}
]});



