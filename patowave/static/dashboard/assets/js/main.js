"use strict";
let isRtl = window.Helpers.isRtl(), isDarkStyle = window.Helpers.isDarkStyle(), menu, animate, isHorizontalLayout = !1;
let customAssetsPath = '/static/assets/' 
let customJsonFile = '/search-bar/api-json/'
document.getElementById("layout-menu") && (isHorizontalLayout = document.getElementById("layout-menu").classList.contains("menu-horizontal")),
function() {
    let d = document.querySelectorAll("#layout-menu")
      , u = (d.forEach(function(e) {
        menu = new Menu(e,{
            orientation: isHorizontalLayout ? "horizontal" : "vertical",
            closeChildren: !!isHorizontalLayout,
            showDropdownOnHover: localStorage.getItem("templateCustomizer-" + templateName + "--ShowDropdownOnHover") ? "true" === localStorage.getItem("templateCustomizer-" + templateName + "--ShowDropdownOnHover") : void 0 === window.templateCustomizer || window.templateCustomizer.settings.defaultShowDropdownOnHover
        }),
        window.Helpers.scrollToActive(animate = !1),
        window.Helpers.mainMenu = menu
    }),
    document.querySelectorAll(".layout-menu-toggle"));
    u.forEach(e=>{
        e.addEventListener("click", e=>{
            if (e.preventDefault(),
            window.Helpers.toggleCollapsed(),
            config.enableMenuLocalStorage && !window.Helpers.isSmallScreen())
                try {
                    localStorage.setItem("templateCustomizer-" + templateName + "--LayoutCollapsed", String(window.Helpers.isCollapsed()))
                } catch (e) {}
        }
        )
    }
    );
    if (document.getElementById("layout-menu")) {
        var t = document.getElementById("layout-menu");
        var o = function() {
            Helpers.isSmallScreen() || document.querySelector(".layout-menu-toggle").classList.add("d-block")
        };
        let e = null;
        t.onmouseenter = function() {
            e = Helpers.isSmallScreen() ? setTimeout(o, 0) : setTimeout(o, 300)
        }
        ,
        t.onmouseleave = function() {
            document.querySelector(".layout-menu-toggle").classList.remove("d-block"),
            clearTimeout(e)
        }
    }
    window.Helpers.swipeIn(".drag-target", function(e) {
        window.Helpers.setCollapsed(!1)
    }),
    window.Helpers.swipeOut("#layout-menu", function(e) {
        window.Helpers.isSmallScreen() && window.Helpers.setCollapsed(!0)
    });
    let e = document.getElementsByClassName("menu-inner")
      , n = document.getElementsByClassName("menu-inner-shadow")[0]
      , s = (0 < e.length && n && e[0].addEventListener("ps-scroll-y", function() {
        this.querySelector(".ps__thumb-y").offsetTop ? n.style.display = "block" : n.style.display = "none"
    }),
    document.querySelector(".style-switcher-toggle"));
    function a(o) {
        const e = [].slice.call(document.querySelectorAll("[data-app-" + o + "-img]"));
        e.map(function(e) {
            var t = e.getAttribute("data-app-" + o + "-img");
            e.src = customAssetsPath + "img/" + t
        })
    }
    window.templateCustomizer && (s && s.addEventListener("click", function() {
        window.Helpers.isLightStyle() ? window.templateCustomizer.setStyle("dark") : window.templateCustomizer.setStyle("light")
    }),
    window.Helpers.isLightStyle() ? (s && (s.querySelector("i").classList.add("bx-moon"),
    new bootstrap.Tooltip(s,{
        title: "Dark mode",
        fallbackPlacements: ["bottom"]
    })),
    a("light")) : (s && (s.querySelector("i").classList.add("bx-sun"),
    new bootstrap.Tooltip(s,{
        title: "Light mode",
        fallbackPlacements: ["bottom"]
    })),
    a("dark"))),
    "undefined" != typeof i18next && "undefined" != typeof i18nextXHRBackend && i18next.use(i18nextXHRBackend).init({
        lng: "en",
        debug: !1,
        fallbackLng: "en",
        backend: {
            loadPath: customAssetsPath + "json/locales/{{lng}}.json"
        },
        returnObjects: !0
    }).then(function(e) {
        i()
    });
    let l = document.getElementsByClassName("dropdown-language");
    if (l.length) {
        let t = l[0].querySelectorAll(".dropdown-item");
        for (let e = 0; e < t.length; e++)
            t[e].addEventListener("click", function() {
                let e = this.getAttribute("data-language")
                  , t = this.querySelector(".flag-icon").getAttribute("class")
                  , o = t.split(" ").filter(function(e) {
                    return 0 !== e.lastIndexOf("fs-", 0)
                });
                t = o.join(" ").trim() + " fs-3";
                for (var n of this.parentNode.children)
                    n.classList.remove("selected");
                this.classList.add("selected"),
                l[0].querySelector(".dropdown-toggle .flag-icon").className = t,
                i18next.changeLanguage(e, (e,t)=>{
                    if (e)
                        return console.log("something went wrong loading", e);
                    i()
                }
                )
            })
    }
    function i() {
        let e = document.querySelectorAll("[data-i18n]")
          , t = document.querySelector('.dropdown-item[data-language="' + i18next.language + '"]');
        t && t.click(),
        e.forEach(function(e) {
            e.innerHTML = i18next.t(e.dataset.i18n)
        })
    }
    function r(e) {
        "show.bs.collapse" == e.type || "show.bs.collapse" == e.type ? e.target.closest(".accordion-item").classList.add("active") : e.target.closest(".accordion-item").classList.remove("active")
    }
    const m = document.querySelector(".dropdown-notifications-all")
      , c = document.querySelectorAll(".dropdown-notifications-read")
      , p = (m && m.addEventListener("click", e=>{
        c.forEach(e=>{
            e.closest(".dropdown-notifications-item").classList.add("marked-as-read")
        }
        )
    }
    ),
    c && c.forEach(t=>{
        t.addEventListener("click", e=>{
            t.closest(".dropdown-notifications-item").classList.toggle("marked-as-read")
        }
        )
    }
    ),
    document.querySelectorAll(".dropdown-notifications-archive"))
      , g = (p.forEach(t=>{
        t.addEventListener("click", e=>{
            t.closest(".dropdown-notifications-item").remove()
        }
        )
    }
    ),
    [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]')))
      , w = (g.map(function(e) {
        return new bootstrap.Tooltip(e)
    }),
    [].slice.call(document.querySelectorAll(".accordion")));
    w.map(function(e) {
        e.addEventListener("show.bs.collapse", r),
        e.addEventListener("hide.bs.collapse", r)
    });
    if (isRtl && Helpers._addClass("dropdown-menu-end", document.querySelectorAll("#layout-navbar .dropdown-menu")),
    window.Helpers.setAutoUpdate(!0),
    window.Helpers.initPasswordToggle(),
    window.Helpers.initSpeechToText(),
    window.Helpers.initNavbarDropdownScrollbar(),
    window.addEventListener("resize", function(e) {
        window.innerWidth >= window.Helpers.LAYOUT_BREAKPOINT && document.querySelector(".search-input-wrapper") && (document.querySelector(".search-input-wrapper").classList.add("d-none"),
        document.querySelector(".search-input").value = ""),
        document.querySelector("[data-template^='horizontal-menu']") && setTimeout(function() {
            window.innerWidth < window.Helpers.LAYOUT_BREAKPOINT ? document.getElementById("layout-menu").classList.contains("menu-horizontal") && menu.switchMenu("vertical") : document.getElementById("layout-menu").classList.contains("menu-vertical") && menu.switchMenu("horizontal")
        }, 100)
    }, !0),
    !isHorizontalLayout && !window.Helpers.isSmallScreen() && ("undefined" != typeof TemplateCustomizer && window.templateCustomizer.settings.defaultMenuCollapsed && window.Helpers.setCollapsed(!0, !1),
    "undefined" != typeof config && config.enableMenuLocalStorage))
        try {
            null !== localStorage.getItem("templateCustomizer-" + templateName + "--LayoutCollapsed") && "false" !== localStorage.getItem("templateCustomizer-" + templateName + "--LayoutCollapsed") && window.Helpers.setCollapsed("true" === localStorage.getItem("templateCustomizer-" + templateName + "--LayoutCollapsed"), !1)
        } catch (e) {}
}(),
"undefined" != typeof $ && $(function() {
    window.Helpers.initSidebarToggle();
    var t, o, e, n = $(".search-toggler"), s = $(".search-input-wrapper"), a = $(".search-input"), l = $(".content-backdrop");
    n.length && n.on("click", function() {
        s.length && (s.toggleClass("d-none"),
        a.focus())
    }),
    $(document).on("keydown", function(e) {
        var t = e.ctrlKey
          , e = 191 === e.which;
        t && e && s.length && (s.toggleClass("d-none"),
        a.focus())
    }),
    a.on("focus", function() {
        s.hasClass("container-xxl") && s.find(".twitter-typeahead").addClass("container-xxl")
    }),
    a && (t = function(n) {
        return function(t, e) {
            let o;
            o = [],
            n.filter(function(e) {
                if (e.name.toLowerCase().startsWith(t.toLowerCase()))
                    o.push(e);
                else {
                    if (e.name.toLowerCase().startsWith(t.toLowerCase()) || !e.name.toLowerCase().includes(t.toLowerCase()))
                        return [];
                    o.push(e),
                    o.sort(function(e, t) {
                        return t.name < e.name ? 1 : -1
                    })
                }
            }),
            e(o)
        }
    }
    ,
    n = "search-vertical.json",
    $("#layout-menu").hasClass("menu-horizontal") && (n = "search-horizontal.json"),
    o = $.ajax({
        url: customJsonFile,
        dataType: "json",
        async: !1
    }).responseJSON,
    a.each(function() {
        var e = $(this);
        a.typeahead({
            hint: !1,
            classNames: {
                menu: "tt-menu navbar-search-suggestion",
                cursor: "active",
                suggestion: "suggestion d-flex justify-content-between px-3 py-2 w-100"
            }
        }, {
            name: "pages",
            display: "name",
            limit: 5,
            source: t(o.pages),
            templates: {
                header: '<h6 class="suggestions-header text-primary mb-0 mx-3 mt-3 pb-2">Pages</h6>',
                suggestion: function({url: e, icon: t, name: o}) {
                    return '<a href="' + e + '"><div><i class="bx ' + t + ' me-2"></i><span class="align-middle">' + o + "</span></div></a>"
                },
                notFound: '<div class="not-found px-3 py-2"><h6 class="suggestions-header text-primary mb-2">Pages</h6><p class="py-2 mb-0"><i class="bx bx-error-circle bx-xs me-2"></i> No Results Found</p></div>'
            }
        }, {
            name: "files",
            display: "name",
            limit: 4,
            source: t(o.files),
            templates: {
                header: '<h6 class="suggestions-header text-primary mb-0 mx-3 mt-3 pb-2">Files</h6>',
                suggestion: function({src: e, name: t, subtitle: o, meta: n}) {
                    return '<a href="javascript:;"><div class="d-flex w-50"><img class="me-3" src="' + customAssetsPath + e + '" alt="' + t + '" height="32"><div class="w-75"><h6 class="mb-0">' + t + '</h6><small class="text-muted">' + o + '</small></div></div><small class="text-muted">' + n + "</small></a>"
                },
                notFound: '<div class="not-found px-3 py-2"><h6 class="suggestions-header text-primary mb-2">Files</h6><p class="py-2 mb-0"><i class="bx bx-error-circle bx-xs me-2"></i> No Results Found</p></div>'
            }
        }, {
            name: "members",
            display: "name",
            limit: 4,
            source: t(o.members),
            templates: {
                header: '<h6 class="suggestions-header text-primary mb-0 mx-3 mt-3 pb-2">Members</h6>',
                suggestion: function({name: e, src: t, subtitle: o, url:u}) {
                    return '<a href="' + u + '"><div class="d-flex align-items-center"><img class="rounded-circle me-3" src="' + t + '" alt="' + e + '" height="32"><div class="user-info"><h6 class="mb-0">' + e + '</h6><small class="text-muted">' + o + "</small></div></div></a>"
                },
                notFound: '<div class="not-found px-3 py-2"><h6 class="suggestions-header text-primary mb-2">Members</h6><p class="py-2 mb-0"><i class="bx bx-error-circle bx-xs me-2"></i> No Results Found</p></div>'
            }
        }).bind("typeahead:render", function() {
            l.addClass("show").removeClass("fade")
        }).bind("typeahead:select", function(e, t) {
            t.url && (window.location = t.url)
        }).bind("typeahead:close", function() {
            a.val(""),
            e.typeahead("val", ""),
            s.addClass("d-none"),
            l.addClass("fade").removeClass("show")
        }),
        a.on("keyup", function() {
            "" == a.val() && l.addClass("fade").removeClass("show")
        })
    }),
    $(".navbar-search-suggestion").each(function() {
        e = new PerfectScrollbar($(this)[0],{
            wheelPropagation: !1,
            suppressScrollX: !0
        })
    }),
    a.on("keyup", function() {
        e.update()
    }))
});
