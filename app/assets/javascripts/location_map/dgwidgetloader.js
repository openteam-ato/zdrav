!function(){
  function o(o) {
    var t = document.getElementById(o);
    t && (t.style.display="none")
  }

  function t(o,t) {
    var i = "https:" === window.location.protocol ? "https:" : "http:";
    return i + "//widgets.2gis.com/widget?type=" + o + "&options=" + encodeURIComponent(JSON.stringify(t))
  }

  function i(o) {
    if (!o.src) return"";
    var t = o.borderColor ?  "1px solid " + o.borderColor : "none";
    return '<iframe frameborder="no" style="border: ' + t + ';" width="' + o.width + '" height="' + o.height + '" src="' + o.src + '"></iframe>'
  }

  window.DG = window.DG || {},
  DG.Widget = DG.Widget || {},
  DG.Widget.Components = DG.Widget.Components || {},
  window.DGWidgetLoader = function(r) {
    o("firmsonmap_biglink"),
    o("firmsonmap_biglink_photo"),
    o("firmsonmap_biglink_route"),
    r = r || {},
    r.org = r.org || [],
    r.pos = r.pos || {},
    r.opt = r.opt || {};
    var n = r.width || 900;
    n = n.toString(), "%" != n.slice(-1) && (n=parseInt(n,10), n=Math.min(1200,n), n=Math.max(500,n), n-=2);
    var e = r.height || 600;
    e = e.toString(), "%" != e.slice(-1) && (e=parseInt(e,10), e=Math.min(1e3,e), e=Math.max(400,e), e-=2);
    for (var s = r.borderColor || "#a3a3a3", a = "", d = 0; d < r.org.length; d++)
      r.org[d].id && (a += r.org[d].id + ",");
    a = a.slice(0, -1);
    var p = {pos: r.pos, opt: r.opt, org: a};
    document.write(i({width: n, height: e, borderColor: s, src: t("firmsonmap", p)}))
  },
  DG.Widget.Components.Loader = function(r) {
    o("2gis_mini_biglink");
    var n, e, s = 700,
        a = 400,
        d = r.resize;
    d ? (n = d.w ? parseInt(d.w, 10) : s, e = d.h ? parseInt(d.h, 10) : a) : (n = s, e = a), document.write(i({width:n,height:e,src:t("mini",r)}))
  }
}();
