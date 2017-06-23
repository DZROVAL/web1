(function(a){a.fn.ajaxSubmit=function(r){if(!this.length){b("ajaxSubmit: skipping submit process - no element selected");return this}if(typeof r=="function"){r={success:r}}var t=a.trim(this.attr("action"));if(t){t=(t.match(/^([^#]+)/)||[])[1]}t=t||window.location.href||"";r=a.extend({url:t,type:this.attr("method")||"GET"},r||{});var u={};this.trigger("form-pre-serialize",[this,r,u]);if(u.veto){b("ajaxSubmit: submit vetoed via form-pre-serialize trigger");return this}if(r.beforeSerialize&&r.beforeSerialize(this,r)===false){b("ajaxSubmit: submit aborted via beforeSerialize callback");return this}var d=this.formToArray(r.semantic);if(r.data){r.extraData=r.data;for(var o in r.data){if(r.data[o] instanceof Array){for(var l in r.data[o]){d.push({name:o,value:r.data[o][l]})}}else{d.push({name:o,value:r.data[o]})}}}if(r.beforeSubmit&&r.beforeSubmit(d,this,r)===false){b("ajaxSubmit: submit aborted via beforeSubmit callback");return this}this.trigger("form-submit-validate",[d,this,r,u]);if(u.veto){b("ajaxSubmit: submit vetoed via form-submit-validate trigger");return this}var s=a.param(d);if(r.type.toUpperCase()=="GET"){r.url+=(r.url.indexOf("?")>=0?"&":"?")+s;r.data=null}else{r.data=s}var c=this,e=[];if(r.resetForm){e.push(function(){c.resetForm()})}if(r.clearForm){e.push(function(){c.clearForm()})}if(!r.dataType&&r.target){var p=r.success||function(){};e.push(function(j){a(r.target).html(j).each(p,arguments)})}else{if(r.success){e.push(r.success)}}r.success=function(j,q){for(var k=0,n=e.length;k<n;k++){e[k].apply(r,[j,q,c])}};var f=a("input:file",this).fieldValue();var h=false;for(var i=0;i<f.length;i++){if(f[i]){h=true}}var m=false;if(r.iframe||h||m){if(r.closeKeepAlive){a.get(r.closeKeepAlive,g)}else{g()}}else{a.ajax(r)}this.trigger("form-submit-notify",[this,r]);return this;function g(){var v=c[0];if(a(":input[name=submit]",v).length){alert('Error: Form elements must not be named "submit".');return}var B=a.extend({},a.ajaxSettings,r);var C=a.extend(true,{},a.extend(true,{},a.ajaxSettings),B);var x="jqFormIO"+(new Date().getTime());var j=a('<iframe id="'+x+'" name="'+x+'" src="about:blank" />');var y=j[0];j.css({position:"absolute",top:"-1000px",left:"-1000px"});var G={aborted:0,responseText:null,responseXML:null,status:0,statusText:"n/a",getAllResponseHeaders:function(){},getResponseHeader:function(){},setRequestHeader:function(){},abort:function(){this.aborted=1;j.attr("src","about:blank")}};var w=B.global;if(w&&!a.active++){a.event.trigger("ajaxStart")}if(w){a.event.trigger("ajaxSend",[G,B])}if(C.beforeSend&&C.beforeSend(G,C)===false){C.global&&a.active--;return}if(G.aborted){return}var q=0;var E=0;var D=v.clk;if(D){var z=D.name;if(z&&!D.disabled){r.extraData=r.extraData||{};r.extraData[z]=D.value;if(D.type=="image"){r.extraData[name+".x"]=v.clk_x;r.extraData[name+".y"]=v.clk_y}}}setTimeout(function(){var K=c.attr("target"),H=c.attr("action");v.setAttribute("target",x);if(v.getAttribute("method")!="POST"){v.setAttribute("method","POST")}if(v.getAttribute("action")!=B.url){v.setAttribute("action",B.url)}if(!r.skipEncodingOverride){c.attr({encoding:"multipart/form-data",enctype:"multipart/form-data"})}if(B.timeout){setTimeout(function(){E=true;k()},B.timeout)}var I=[];try{if(r.extraData){for(var J in r.extraData){I.push(a('<input type="hidden" name="'+J+'" value="'+r.extraData[J]+'" />').appendTo(v)[0])}}j.appendTo("body");y.attachEvent?y.attachEvent("onload",k):y.addEventListener("load",k,false);v.submit()}finally{v.setAttribute("action",H);K?v.setAttribute("target",K):c.removeAttr("target");a(I).remove()}},10);var A=0;function k(){if(q++){return}y.detachEvent?y.detachEvent("onload",k):y.removeEventListener("load",k,false);var J=true;try{if(E){throw"timeout"}var n,H;H=y.contentWindow?y.contentWindow.document:y.contentDocument?y.contentDocument:y.document;if((H.body==null||H.body.innerHTML=="")&&!A){A=1;q--;setTimeout(k,100);return}G.responseText=H.body?H.body.innerHTML:null;G.responseXML=H.XMLDocument?H.XMLDocument:H;G.getResponseHeader=function(L){var M={"content-type":B.dataType};return M[L]};if(B.dataType=="json"||B.dataType=="script"){var K=H.getElementsByTagName("textarea")[0];G.responseText=K?K.value:G.responseText}else{if(B.dataType=="xml"&&!G.responseXML&&G.responseText!=null){G.responseXML=F(G.responseText)}}n=a.httpData(G,B.dataType)}catch(I){J=false;a.handleError(B,G,"error",I)}if(J){B.success(n,"success");if(w){a.event.trigger("ajaxSuccess",[G,B])}}if(w){a.event.trigger("ajaxComplete",[G,B])}if(w&&!--a.active){a.event.trigger("ajaxStop")}if(B.complete){B.complete(G,J?"success":"error")}setTimeout(function(){j.remove();G.responseXML=null},100)}function F(H,n){if(window.ActiveXObject){n=new ActiveXObject("Microsoft.XMLDOM");n.async="false";n.loadXML(H)}else{n=(new DOMParser()).parseFromString(H,"text/xml")}return(n&&n.documentElement&&n.documentElement.tagName!="parsererror")?n:null}}};a.fn.ajaxForm=function(c){return this.ajaxFormUnbind().bind("submit.form-plugin",function(){a(this).ajaxSubmit(c);return false}).each(function(){a(":submit,input:image",this).bind("click.form-plugin",function(d){var f=this.form;f.clk=this;if(this.type=="image"){if(d.offsetX!=undefined){f.clk_x=d.offsetX;f.clk_y=d.offsetY}else{if(typeof a.fn.offset=="function"){var g=a(this).offset();f.clk_x=d.pageX-g.left;f.clk_y=d.pageY-g.top}else{f.clk_x=d.pageX-this.offsetLeft;f.clk_y=d.pageY-this.offsetTop}}}setTimeout(function(){f.clk=f.clk_x=f.clk_y=null},10)})})};a.fn.ajaxFormUnbind=function(){this.unbind("submit.form-plugin");return this.each(function(){a(":submit,input:image",this).unbind("click.form-plugin")})};a.fn.formToArray=function(q){var d=[];if(this.length==0){return d}var g=this[0];var f=q?g.getElementsByTagName("*"):g.elements;if(!f){return d}for(var h=0,o=f.length;h<o;h++){var e=f[h];var p=e.name;if(!p){continue}if(q&&g.clk&&e.type=="image"){if(!e.disabled&&g.clk==e){d.push({name:p,value:a(e).val()});d.push({name:p+".x",value:g.clk_x},{name:p+".y",value:g.clk_y})}continue}var r=a.fieldValue(e,true);if(r&&r.constructor==Array){for(var l=0,m=r.length;l<m;l++){d.push({name:p,value:r[l]})}}else{if(r!==null&&typeof r!="undefined"){d.push({name:p,value:r})}}}if(!q&&g.clk){var c=a(g.clk),k=c[0],p=k.name;if(p&&!k.disabled&&k.type=="image"){d.push({name:p,value:c.val()});d.push({name:p+".x",value:g.clk_x},{name:p+".y",value:g.clk_y})}}return d};a.fn.formSerialize=function(c){return a.param(this.formToArray(c))};a.fn.fieldSerialize=function(d){var c=[];this.each(function(){var g=this.name;if(!g){return}var h=a.fieldValue(this,d);if(h&&h.constructor==Array){for(var e=0,f=h.length;e<f;e++){c.push({name:g,value:h[e]})}}else{if(h!==null&&typeof h!="undefined"){c.push({name:this.name,value:h})}}});return a.param(c)};a.fn.fieldValue=function(f){for(var h=[],d=0,e=this.length;d<e;d++){var c=this[d];var g=a.fieldValue(c,f);if(g===null||typeof g=="undefined"||(g.constructor==Array&&!g.length)){continue}g.constructor==Array?a.merge(h,g):h.push(g)}return h};a.fieldValue=function(d,m){var h=d.name,o=d.type,p=d.tagName.toLowerCase();if(typeof m=="undefined"){m=true}if(m&&(!h||d.disabled||o=="reset"||o=="button"||(o=="checkbox"||o=="radio")&&!d.checked||(o=="submit"||o=="image")&&d.form&&d.form.clk!=d||p=="select"&&d.selectedIndex==-1)){return null}if(p=="select"){var f=d.selectedIndex;if(f<0){return null}var c=[],l=d.options;var j=(o=="select-one");var g=(j?f+1:l.length);for(var e=(j?f:0);e<g;e++){var k=l[e];if(k.selected){var q=k.value;if(!q){q=(k.attributes&&k.attributes.value&&!(k.attributes.value.specified))?k.text:k.value}if(j){return q}c.push(q)}}return c}return d.value};a.fn.clearForm=function(){return this.each(function(){a("input,select,textarea",this).clearFields()})};a.fn.clearFields=a.fn.clearInputs=function(){return this.each(function(){var c=this.type,d=this.tagName.toLowerCase();if(c=="text"||c=="password"||d=="textarea"){this.value=""}else{if(c=="checkbox"||c=="radio"){this.checked=false}else{if(d=="select"){this.selectedIndex=-1}}}})};a.fn.resetForm=function(){return this.each(function(){if(typeof this.reset=="function"||(typeof this.reset=="object"&&!this.reset.nodeType)){this.reset()}})};a.fn.enable=function(c){if(c==undefined){c=true}return this.each(function(){this.disabled=!c})};a.fn.selected=function(c){if(c==undefined){c=true}return this.each(function(){var e=this.type;if(e=="checkbox"||e=="radio"){this.checked=c}else{if(this.tagName.toLowerCase()=="option"){var d=a(this).parent("select");if(c&&d[0]&&d[0].type=="select-one"){d.find("option").selected(false)}this.selected=c}}})};function b(){if(a.fn.ajaxSubmit.debug&&window.console&&window.console.log){window.console.log("[jquery.form] "+Array.prototype.join.call(arguments,""))}}})(jQuery);
jQuery.fn.extend({OpenDiv:function(){var i,h;i=window.screen.availWidth;if(window.screen.availHeight>document.body.scrollHeight){h=window.screen.availHeight}else{h=document.body.scrollHeight+20}var e=document.createElement("div");e.setAttribute("id","BigDiv");e.style.position="absolute";e.style.top="0";e.style.left="0";e.style.background="#111";e.style.filter="Alpha(opacity=70);";e.style.opacity="0.7";e.style.width=i+"px";e.style.height=h+"px";e.style.zIndex="10000";$("body").attr("scroll","no");document.body.appendChild(e);$("#BigDiv").data("divbox_selectlist",$("select:visible"));$("select:visible").hide();$("#BigDiv").attr("divbox_scrolltop",$.ScrollPosition().Top);$("#BigDiv").attr("divbox_scrollleft",$.ScrollPosition().Left);$("#BigDiv").attr("htmloverflow",$("html").css("overflow"));window.scrollTo($("#BigDiv").attr("divbox_scrollleft"),$("#BigDiv").attr("divbox_scrolltop"));var g=this.width();var f=this.height();g=parseInt(g);f=parseInt(f);var k=$.PageSize().Width;var c=$.PageSize().Height;var d=$.ScrollPosition().Left;var j=$.ScrollPosition().Top;var b=((c/2)-(f/2))<20?20:((c/2)-(f/2));var a=(k/2)-(g/2);this.css("position","absolute");this.css("z-index","10001");this.css("background","#fff");this.css("left",a+"px");this.css("top",b+"px");if($.browser.mozilla){this.show();return}this.fadeIn("fast")},CloseDiv:function(){if($.browser.mozilla){this.hide()}else{this.fadeOut("fast")}$("html").css("overflow",$("#BigDiv").attr("htmloverflow"));window.scrollTo($("#BigDiv").attr("divbox_scrollleft"),$("#BigDiv").attr("divbox_scrolltop"));$("#BigDiv").data("divbox_selectlist").show();$("#BigDiv").remove()}});$.extend({PageSize:function(){var b=0;var a=0;b=window.innerWidth!=null?window.innerWidth:document.documentElement&&document.documentElement.clientWidth?document.documentElement.clientWidth:document.body!=null?document.body.clientWidth:null;a=window.innerHeight!=null?window.innerHeight:document.documentElement&&document.documentElement.clientHeight?document.documentElement.clientHeight:document.body!=null?document.body.clientHeight:null;return{Width:b,Height:a}},ScrollPosition:function(){var b=0,a=0;if($.browser.mozilla){b=window.pageYOffset;a=window.pageXOffset}else{if($.browser.msie){b=document.documentElement.scrollTop;a=document.documentElement.scrollLeft}else{if(document.body){b=document.body.scrollTop;a=document.body.scrollLeft}}}return{Top:b,Left:a}}});function openDiv(a){$(a).OpenDiv()}function closeDiv(a){$(a).CloseDiv()}function openD(a){openDiv(document.getElementById(a))};
(function(a){a.fn.VMiddleImg=function(c){var b={width:null,height:null};var d=a.extend({},b,c);return a(this).each(function(){var e=a(this);var f=e.height();var g=e.width();var h=d.height||e.parent().height();var i=d.width||e.parent().width();var j=f/g;if(f>h&&g>i){if(f>g){e.width(i);e.height(i*j)}else{e.height(h);e.width(h/j)}f=e.height();g=e.width();if(f>g){e.css("top",(h-f)/2)}else{e.css("left",(i-g)/2)}}else{if(g>i){e.css("left",(i-g)/2)}e.css("top",(h-f)/2)}})}})(jQuery);
var scrolltotop={setting:{startline:100,scrollto:0,scrollduration:500,fadeduration:[500,100]},controlHTML:'<a href="#top" class="backtop">&nbsp;</a>',controlattrs:{offsetx:20,offsety:64},anchorkeyword:"#top",state:{isvisible:false,shouldvisible:false},scrollup:function(){if(!this.cssfixedsupport){this.$control.css({opacity:0})}var a=isNaN(this.setting.scrollto)?this.setting.scrollto:parseInt(this.setting.scrollto);if(typeof a=="string"&&jQuery("#"+a).length==1){a=jQuery("#"+a).offset().top}else{a=this.setting.scrollto}this.$body.animate({scrollTop:a},this.setting.scrollduration)},keepfixed:function(){var a=jQuery(window);var b=a.scrollLeft()+a.width()-this.$control.width()-this.controlattrs.offsetx;var c=a.scrollTop()+a.height()-this.$control.height()-this.controlattrs.offsety;this.$control.css({left:b+"px",top:c+"px"})},togglecontrol:function(){var a=jQuery(window).scrollTop();if(!this.cssfixedsupport){this.keepfixed()}this.state.shouldvisible=(a>=this.setting.startline)?true:false;if(this.state.shouldvisible&&!this.state.isvisible){this.$control.stop().animate({opacity:1},this.setting.fadeduration[0]);this.state.isvisible=true}else{if(this.state.shouldvisible==false&&this.state.isvisible){this.$control.stop().animate({opacity:0},this.setting.fadeduration[1]);this.state.isvisible=false}}},init:function(){jQuery(document).ready(function(a){var c=scrolltotop;var b=document.all;c.cssfixedsupport=!b||b&&document.compatMode=="CSS1Compat"&&window.XMLHttpRequest;c.$body=(window.opera)?(document.compatMode=="CSS1Compat"?a("html"):a("body")):a("html,body");c.$control=a('<div id="backtop">'+c.controlHTML+"</div>").css({position:c.cssfixedsupport?"fixed":"absolute",bottom:c.controlattrs.offsety,right:c.controlattrs.offsetx,opacity:0,cursor:"pointer"}).appendTo("body");if(document.all&&!window.XMLHttpRequest&&c.$control.text()!=""){c.$control.css({width:c.$control.width()})}c.togglecontrol();a('a[href="'+c.anchorkeyword+'"]').click(function(){c.scrollup();return false});a(window).bind("scroll resize",function(d){c.togglecontrol()})})}};scrolltotop.init();
!function(c){var d;d=function(){function a(e,f){this.elements={wrap:e,ul:e.children(),li:e.children().children()},this.settings=c.extend({},c.fn.marquee.defaults,f),this.cache={allowMarquee:!0}}return a.prototype.init=function(){this.setStyle(),this.move(),this.bind()},a.prototype.setStyle=function(){var i,j,k,l,m,n,o,p;switch(l=this.elements.li.outerWidth(!0),k=this.elements.li.outerHeight(!0),j=Math.max(parseInt(this.elements.li.css("margin-top"),10),parseInt(this.elements.li.css("margin-bottom"),10)),this.settings.type){case"horizontal":p=this.settings.showNum*l,o=k,n=9999,m="auto",i="left",this.cache.stepW=this.settings.stepLen*l,this.cache.prevAnimateObj={left:-this.cache.stepW},this.cache.nextAnimateObj={left:0},this.cache.leftOrTop="left";break;case"vertical":p=l,o=this.settings.showNum*k-j,n="auto",m=9999,i="none",this.cache.stepW=this.settings.stepLen*k-j,this.cache.prevAnimateObj={top:-this.cache.stepW},this.cache.nextAnimateObj={top:0},this.cache.leftOrTop="top"}this.elements.wrap.css({position:"relative",width:p,height:o,overflow:"hidden"}),this.elements.ul.css({position:"relative",width:n,height:m}),this.elements.li.css({"float":i})},a.prototype.bind=function(){var g,h,i,j,k,l;l=this,null!=(g=this.settings.prevElement)&&g.click(function(b){b.preventDefault(),l.prev()}),null!=(h=this.settings.nextElement)&&h.click(function(b){b.preventDefault(),l.next()}),null!=(i=this.settings.pauseElement)&&i.click(function(b){b.preventDefault(),l.pause()}),null!=(j=this.settings.resumeElement)&&j.click(function(b){b.preventDefault(),l.resume()}),null!=(k=this.elements.wrap)&&k.hover(function(){l.pause()},function(){l.resume()})},a.prototype.move=function(){var e,f,g;if(g=this,this.settings.auto){switch(this.settings.direction){case"forward":f=g.prev;break;case"backward":f=g.next}e=g.settings.interval,setTimeout(function(){f.call(g),setTimeout(arguments.callee,e)},e),this.cache.moveBefore=this.cache.moveAfter=function(){return null}}else{this.cache.moveBefore=function(){return g.cache.allowMarquee=!1},this.cache.moveAfter=function(){return g.cache.allowMarquee=!0}}},a.prototype.prev=function(){var e,f,g;g=this,this.cache.allowMarquee&&(this.cache.moveBefore.call(this),this.settings.prevBefore.call(this),f=this.elements.ul,e=f.children().slice(0,this.settings.stepLen),e.clone().appendTo(f),f.animate(this.cache.prevAnimateObj,this.settings.speed,function(){f.css(g.cache.leftOrTop,0),e.remove(),g.cache.moveAfter.call(g),g.settings.prevAfter.call(g)}))},a.prototype.next=function(){var e,f,g;g=this,this.cache.allowMarquee&&(this.cache.moveBefore.call(this),this.settings.nextBefore.call(this),f=this.elements.ul,e=f.children().slice(-this.settings.stepLen),e.clone().prependTo(f),f.css(g.cache.leftOrTop,-this.cache.stepW).animate(this.cache.nextAnimateObj,this.settings.speed,function(){e.remove(),g.cache.moveAfter.call(g),g.settings.nextAfter.call(g)}))},a.prototype.pause=function(){this.settings.pauseBefore.call(this),this.cache.allowMarquee=!1,this.settings.pauseAfter.call(this)},a.prototype.resume=function(){this.settings.resumeBefore.call(this),this.cache.allowMarquee=!0,this.settings.resumeAfter.call(this)},a}(),c.fn.marquee=function(a){this.each(function(){var b;b=new d(c(this),a),b.init()})},c.fn.marquee.defaults={auto:!0,interval:3000,direction:"forward",speed:500,showNum:1,stepLen:1,type:"horizontal",prevElement:null,prevBefore:function(){},prevAfter:function(){},nextElement:null,nextBefore:function(){},nextAfter:function(){},pauseElement:null,pauseBefore:function(){},pauseAfter:function(){},resumeElement:null,resumeBefore:function(){},resumeAfter:function(){}}}(jQuery);
(function(a,e,c,d){var b=a(e);a.fn.lazyload=function(h){var g=this;var f;var i={threshold:0,failure_limit:0,event:"scroll",effect:"show",container:e,data_attribute:"original",skip_invisible:true,appear:null,load:null};function j(){var k=0;g.each(function(){var l=a(this);if(i.skip_invisible&&!l.is(":visible")){return}if(a.abovethetop(this,i)||a.leftofbegin(this,i)){}else{if(!a.belowthefold(this,i)&&!a.rightoffold(this,i)){l.trigger("appear");k=0}else{if(++k>i.failure_limit){return false}}}})}if(h){if(d!==h.failurelimit){h.failure_limit=h.failurelimit;delete h.failurelimit}if(d!==h.effectspeed){h.effect_speed=h.effectspeed;delete h.effectspeed}a.extend(i,h)}f=(i.container===d||i.container===e)?b:a(i.container);if(0===i.event.indexOf("scroll")){f.bind(i.event,function(k){return j()})}this.each(function(){var l=this;var k=a(l);l.loaded=false;k.one("appear",function(){if(!this.loaded){if(i.appear){var m=g.length;i.appear.call(l,m,i)}a("<img />").bind("load",function(){if(h.done){k.hide().attr("src",k.data(i.data_attribute)).show(h.done(k))}else{k.hide().attr("src",k.data(i.data_attribute)).show()}l.loaded=true;var o=a.grep(g,function(p){return !p.loaded});g=a(o);if(i.load){var n=g.length;i.load.call(l,n,i)}}).attr("src",k.data(i.data_attribute));if(h.done){h.done(k)}}});if(0!==i.event.indexOf("scroll")){k.bind(i.event,function(m){if(!l.loaded){k.trigger("appear")}})}});b.bind("resize",function(k){j()});if((/iphone|ipod|ipad.*os 5/gi).test(navigator.appVersion)){b.bind("pageshow",function(k){if(k.originalEvent.persisted){g.each(function(){a(this).trigger("appear")})}})}a(e).load(function(){j()});return this};a.belowthefold=function(f,h){var g;if(h.container===d||h.container===e){g=b.height()+b.scrollTop()}else{g=a(h.container).offset().top+a(h.container).height()}return g<=a(f).offset().top-h.threshold};a.rightoffold=function(f,h){var g;if(h.container===d||h.container===e){g=b.width()+b.scrollLeft()}else{g=a(h.container).offset().left+a(h.container).width()}return g<=a(f).offset().left-h.threshold};a.abovethetop=function(f,h){var g;if(h.container===d||h.container===e){g=b.scrollTop()}else{g=a(h.container).offset().top}return g>=a(f).offset().top+h.threshold+a(f).height()};a.leftofbegin=function(f,h){var g;if(h.container===d||h.container===e){g=b.scrollLeft()}else{g=a(h.container).offset().left}return g>=a(f).offset().left+h.threshold+a(f).width()};a.inviewport=function(f,g){return !a.rightoffold(f,g)&&!a.leftofbegin(f,g)&&!a.belowthefold(f,g)&&!a.abovethetop(f,g)};a.extend(a.expr[":"],{"below-the-fold":function(f){return a.belowthefold(f,{threshold:0})},"above-the-top":function(f){return !a.belowthefold(f,{threshold:0})},"right-of-screen":function(f){return a.rightoffold(f,{threshold:0})},"left-of-screen":function(f){return !a.rightoffold(f,{threshold:0})},"in-viewport":function(f){return a.inviewport(f,{threshold:0})},"above-the-fold":function(f){return !a.belowthefold(f,{threshold:0})},"right-of-fold":function(f){return a.rightoffold(f,{threshold:0})},"left-of-fold":function(f){return !a.rightoffold(f,{threshold:0})}})})(jQuery,window,document);
var swfobject = function () {
    function A() {
        var a, c, d;
        if (!t) {
            try {
                a = i.getElementsByTagName("body")[0].appendChild(Q("span")),
a.parentNode.removeChild(a)
            }
            catch (b) {
                return
            }
            for (t = !0, c = l.length, d = 0; c > d; d++)
                l[d]()
        }
    }
    function B(a) {
        t ? a() : l[l.length] = a
    }
    function C(b) {
        if (typeof h.addEventListener != a)
            h.addEventListener("load", b, !1);
        else if (typeof i.addEventListener != a)
            i.addEventListener("load", b, !1);
        else if (typeof h.attachEvent != a)
            R(h, "onload", b);
        else if ("function" == typeof h.onload) {
            var c = h.onload;
            h.onload = function () {
                c(), b()
            }
        }
        else
            h.onload = b
    }
    function D() {
        k ? E() : F()
    }
    function E() {
        var f, g, c = i.getElementsByTagName("body")[0], d = Q(b);
        d.setAttribute("type", e),
        f = c.appendChild(d),
        f ? (g = 0, function () {
            if (typeof f.GetVariable != a) {
                var b = f.GetVariable("$version");
                b && (b = b.split(" ")[1].split(","), y.pv = [parseInt(b[0], 10), parseInt(b[1], 10), parseInt(b[2], 10)])
            }
            else if (10 > g)
                return g++,
setTimeout(arguments.callee, 10),
void 0;
            c.removeChild(d),
            f = null,
F()
        } ()) : F()
    }
    function F() {
        var c, d, e, f, g, h, i, j, k, l, n, b = m.length;
        if (b > 0)
            for (c = 0; b > c; c++)
                if (d = m[c].id, e = m[c].callbackFn, f = { success: !1, id: d }, y.pv[0] > 0) {
                    if (g = P(d))
                        if (!S(m[c].swfVersion) || y.wk && y.wk < 312)
                            if (m[c].expressInstall && H()) {
                                for (h = {},
                                h.data = m[c].expressInstall,
                                h.width = g.getAttribute("width") || "0",
                                 h.height = g.getAttribute("height") || "0",
                                 g.getAttribute("class") && (h.styleclass = g.getAttribute("class")),
g.getAttribute("align") && (h.align = g.getAttribute("align")),
i = {},
j = g.getElementsByTagName("param"),
k = j.length,
l = 0;
k > l;
l++)
                                    "movie" != j[l].getAttribute("name").toLowerCase() && (i[j[l].getAttribute("name")] = j[l].getAttribute("value"));
                                I(h, i, d, e)
                            }
                            else
                                J(g), e && e(f);
                        else
                            U(d, !0), e && (f.success = !0, f.ref = G(d), e(f))
                }
                else
                    U(d, !0), e && (n = G(d), n && typeof n.SetVariable != a && (f.success = !0, f.ref = n), e(f))
    }
    function G(c) {
        var f, d = null, e = P(c);
        return e && "OBJECT" == e.nodeName && (typeof e.SetVariable != a ? d = e : (f = e.getElementsByTagName(b)[0], f && (d = f))), d
    }
    function H() {
        return !u && S("6.0.65") && (y.win || y.mac) && !(y.wk && y.wk < 312)
    }
    function I(b, c, d, e) {
        var g, j, k, l;
        u = !0, r = e || null,
s = { success: !1, id: d },
g = P(d),
g && ("OBJECT" == g.nodeName ? (p = K(g),
q = null) : (p = g, q = d),
b.id = f,
(typeof b.width == a || !/%$/.test(b.width) && parseInt(b.width, 10) < 310) && (b.width = "310"),
(typeof b.height == a || !/%$/.test(b.height) && parseInt(b.height, 10) < 137) && (b.height = "137"),
i.title = i.title.slice(0, 47) + " - Flash Player Installation",
j = y.ie && y.win ? "ActiveX" : "PlugIn",
k = "MMredirectURL=" + h.location.toString().replace(/&/g, "%26") + "&MMplayerType=" + j + "&MMdoctitle=" + i.title,
typeof c.flashvars != a ? c.flashvars += "&" + k : c.flashvars = k,
y.ie && y.win && 4 != g.readyState && (l = Q("div"),
d += "SWFObjectNew",
l.setAttribute("id", d),
g.parentNode.insertBefore(l, g),
g.style.display = "none",
function () {
    4 == g.readyState ? g.parentNode.removeChild(g) : setTimeout(arguments.callee, 10)
} ()), L(b, c, d))
    } function J(a) {
        if (y.ie && y.win && 4 != a.readyState) {
            var b = Q("div"); a.parentNode.insertBefore(b, a), b.parentNode.replaceChild(K(a), b), a.style.display = "none",
    function () {
        4 == a.readyState ? a.parentNode.removeChild(a) : setTimeout(arguments.callee, 10)
    } ()
        }
        else a.parentNode.replaceChild(K(a), a)
    } function K(a) {
        var d, e, f, g, c = Q("div"); if (y.win && y.ie) c.innerHTML = a.innerHTML;
        else if (d = a.getElementsByTagName(b)[0], d && (e = d.childNodes))
            for (f = e.length, g = 0; f > g; g++) 1 == e[g].nodeType && "PARAM" == e[g].nodeName || 8 == e[g].nodeType || c.appendChild(e[g].cloneNode(!0));
        return c
    }
    function L(c, d, f) {
        var g, i, j, k, l, m, o, p, h = P(f);
        if (y.wk && y.wk < 312)
            return g;
        if (h)
            if (typeof c.id == a && (c.id = f), y.ie && y.win) {
                i = "";
                for (j in c)
                    c[j] != Object.prototype[j] && ("data" == j.toLowerCase() ? d.movie = c[j] : "styleclass" == j.toLowerCase() ? i += ' class="' + c[j] + '"' : "classid" != j.toLowerCase() && (i += " " + j + '="' + c[j] + '"')); k = "";
                for (l in d)
                    d[l] != Object.prototype[l] && (k += '<param name="' + l + '" value="' + d[l] + '" />');
                h.outerHTML = '<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"' + i + ">" + k + "</object>",
    n[n.length] = c.id,
    g = P(c.id)
            }
            else {
                m = Q(b), m.setAttribute("type", e);
                for (o in c) c[o] != Object.prototype[o] && ("styleclass" == o.toLowerCase() ? m.setAttribute("class", c[o]) : "classid" != o.toLowerCase() && m.setAttribute(o, c[o]));
                for (p in d) d[p] != Object.prototype[p] && "movie" != p.toLowerCase() && M(m, p, d[p]);
                h.parentNode.replaceChild(m, h), g = m
            }
        return g
    }
    function M(a, b, c) {
        var d = Q("param"); d.setAttribute("name", b), d.setAttribute("value", c), a.appendChild(d)
    }
    function N(a) {
        var b = P(a); b && "OBJECT" == b.nodeName && (y.ie && y.win ? (b.style.display = "none",
    function () { 4 == b.readyState ? O(a) : setTimeout(arguments.callee, 10) } ()) : b.parentNode.removeChild(b))
    }
    function O(a) {
        var c, b = P(a); if (b) {
            for (c in b) "function" == typeof b[c] && (b[c] = null);
            b.parentNode.removeChild(b)
        }
    }
    function P(a) {
        var b = null;
        try {
            b = i.getElementById(a)
        }
        catch (c) { }
        return b
    }
    function Q(a) {
        return i.createElement(a)
    }
    function R(a, b, c) {
        a.attachEvent(b, c),
        o[o.length] = [a, b, c]
    }
    function S(a) {
        var b = y.pv, c = a.split(".");
        return c[0] = parseInt(c[0], 10), c[1] = parseInt(c[1], 10) || 0, c[2] = parseInt(c[2], 10) || 0, b[0] > c[0] || b[0] == c[0] && b[1] > c[1] || b[0] == c[0] && b[1] == c[1] && b[2] >= c[2] ? !0 : !1
    }
    function T(c, d, e, f) {
        var g, h, j; y.ie && y.mac || (g = i.getElementsByTagName("head")[0],
        g && (h = e && "string" == typeof e ? e : "screen",
        f && (v = null, w = null), v && w == h || (j = Q("style"),
        j.setAttribute("type", "text/css"),
        j.setAttribute("media", h),
        v = g.appendChild(j), y.ie && y.win && typeof i.styleSheets != a && i.styleSheets.length > 0 && (v = i.styleSheets[i.styleSheets.length - 1]), w = h),
        y.ie && y.win ? v && typeof v.addRule == b && v.addRule(c, d) : v && typeof i.createTextNode != a && v.appendChild(i.createTextNode(c + " {" + d + "}"))))
    }
    function U(a, b) {
        if (x) {
            var c = b ? "visible" : "hidden"; t && P(a) ? P(a).style.visibility = c : T("#" + a, "visibility:" + c)
        }
    }
    function V(b) {
        var c = /[\\\"<>\.;]/, d = null != c.exec(b);
        return d && typeof encodeURIComponent != a ? encodeURIComponent(b) : b
    }
    var p, q, r, s, v, w, a = "undefined", b = "object", c = "Shockwave Flash", d = "ShockwaveFlash.ShockwaveFlash", e = "application/x-shockwave-flash",
         f = "SWFObjectExprInst", g = "onreadystatechange", h = window,
         i = document, j = navigator, k = !1, l = [D], m = [], n = [], o = [], t = !1, u = !1, x = !0,
         y = function () {
             var s,
         f = typeof i.getElementById != a && typeof i.getElementsByTagName != a && typeof i.createElement != a,
         g = j.userAgent.toLowerCase(),
         l = j.platform.toLowerCase(),
         m = l ? /win/.test(l) : /win/.test(g),
         n = l ? /mac/.test(l) : /mac/.test(g),
         o = /webkit/.test(g) ? parseFloat(g.replace(/^.*webkit\/(\d+(\.\d+)?).*$/, "$1")) : !1,
         p = !1,
         q = [0, 0, 0],
         r = null;
             if (typeof j.plugins != a && typeof j.plugins[c] == b) r = j.plugins[c].description, !r || typeof j.mimeTypes != a && j.mimeTypes[e] && !j.mimeTypes[e].enabledPlugin || (k = !0, p = !1, r = r.replace(/^.*\s+(\S+\s+\S+$)/, "$1"), q[0] = parseInt(r.replace(/^(.*)\..*$/, "$1"), 10), q[1] = parseInt(r.replace(/^.*\.(.*)\s.*$/, "$1"), 10), q[2] = /[a-zA-Z]/.test(r) ? parseInt(r.replace(/^.*[a-zA-Z]+(.*)$/, "$1"), 10) : 0);
             else if (typeof h.ActiveXObject != a)
                 try {
                     s = new ActiveXObject(d),
          s && (r = s.GetVariable("$version"),
          r && (p = !0, r = r.split(" ")[1].split(","),
          q = [parseInt(r[0], 10), parseInt(r[1], 10), parseInt(r[2], 10)]))
                 }
                 catch (t) { }
             return { w3: f, pv: q, wk: o, ie: p, win: m, mac: n }
         } ();
    return function () {
        y.w3 && ((typeof i.readyState != a && "complete" == i.readyState || typeof i.readyState == a && (i.getElementsByTagName("body")[0] || i.body)) && A(), t || (typeof i.addEventListener != a && i.addEventListener("DOMContentLoaded", A, !1), y.ie && y.win && (i.attachEvent(g, function () { 
        "complete" == i.readyState && (i.detachEvent(g, arguments.callee), A()) }),
           h == top && function () {
               if (!t) {
                   try {
                       i.documentElement.doScroll("left")
                   }
                   catch (a) {
                       return setTimeout(arguments.callee, 0), void 0
                   } A()
               }
           } ()),
           y.wk && function () {
               return t ? void 0 : /loaded|complete/.test(i.readyState) ? (A(), void 0) : (setTimeout(arguments.callee, 0), void 0)
           } (), C(A)))
    } (), function () {
        y.ie && y.win && window.attachEvent("onunload", function () {
            var b, c, d, e, f, a = o.length;
            for (b = 0; a > b; b++) o[b][0].detachEvent(o[b][1], o[b][2]);
            for (c = n.length, d = 0; c > d; d++) N(n[d]);
            for (e in y) y[e] = null; y = null;
            for (f in swfobject) swfobject[f] = null; swfobject = null
        })
    } (), { registerObject: function (a, b, c, d) {
        if (y.w3 && a && b) {
            var e = {}; e.id = a, e.swfVersion = b, e.expressInstall = c, e.callbackFn = d, m[m.length] = e, U(a, !1)
        }
        else d && d({ success: !1, id: a })
    }, getObjectById: function (a) {
        return y.w3 ? G(a) : void 0
    }, embedSWF: function (c, d, e, f, g, h, i, j, k, l) {
        var m = { success: !1, id: d }; y.w3 && !(y.wk && y.wk < 312) && c && d && e && f && g ? (U(d, !1), B(function () {
            var n, o, p, q, r, s;
            if (e += "", f += "", n = {}, k && typeof k === b)
                for (o in k) n[o] = k[o];
            if (n.data = c, n.width = e, n.height = f, p = {}, j && typeof j === b)
                for (q in j) p[q] = j[q];
            if (i && typeof i === b)
                for (r in i)
                    typeof p.flashvars != a ? p.flashvars += "&" + r + "=" + i[r] : p.flashvars = r + "=" + i[r];
            if (S(g)) s = L(n, p, d), n.id == d && U(d, !0), m.success = !0, m.ref = s;
            else {
                if (h && H())
                    return n.data = h, I(n, p, d, l), void 0; U(d, !0)
            } l && l(m)
        })) : l && l(m)
    }, switchOffAutoHideShow: function () {
        x = !1
    }, ua: y, getFlashPlayerVersion: function () {
        return { major: y.pv[0], minor: y.pv[1], release: y.pv[2] }
    }, hasFlashPlayerVersion: S, createSWF: function (a, b, c) {
        return y.w3 ? L(a, b, c) : void 0
    }, showExpressInstall: function (a, b, c, d) {
        y.w3 && H() && I(a, b, c, d)
    }, removeSWF: function (a) {
        y.w3 && N(a)
    }, createCSS: function (a, b, c, d) {
        y.w3 && T(a, b, c, d)
    }, addDomLoadEvent: B, addLoadEvent: C, getQueryParamValue: function (a) {
        var c, d, b = i.location.search || i.location.hash;
        if (b) {
            if (/\?/.test(b) && (b = b.split("?")[1]), null == a)
                return V(b);
            for (c = b.split("&"), d = 0; d < c.length; d++)
                if (c[d].substring(0, c[d].indexOf("=")) == a)
                    return V(c[d].substring(c[d].indexOf("=") + 1))
        }
        return ""
    },
        expressInstallCallback: function () {
            if (u) {
                var a = P(f);
                a && p && (a.parentNode.replaceChild(p, a), q && (U(q, !0), y.ie && y.win && (p.style.display = "block")), r && r(s)), u = !1
            } 
        } 
    }
} ();
