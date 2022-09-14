! function(t, e) { for (var n in e) t[n] = e[n] }(window, function(t) {
    var e = {};

    function n(i) { if (e[i]) return e[i].exports; var r = e[i] = { i: i, l: !1, exports: {} }; return t[i].call(r.exports, r, r.exports, n), r.l = !0, r.exports }
    return n.m = t, n.c = e, n.d = function(t, e, i) { n.o(t, e) || Object.defineProperty(t, e, { enumerable: !0, get: i }) }, n.r = function(t) { "undefined" != typeof Symbol && Symbol.toStringTag && Object.defineProperty(t, Symbol.toStringTag, { value: "Module" }), Object.defineProperty(t, "__esModule", { value: !0 }) }, n.t = function(t, e) {
        if (1 & e && (t = n(t)), 8 & e) return t;
        if (4 & e && "object" == typeof t && t && t.__esModule) return t;
        var i = Object.create(null);
        if (n.r(i), Object.defineProperty(i, "default", { enumerable: !0, value: t }), 2 & e && "string" != typeof t)
            for (var r in t) n.d(i, r, function(e) { return t[e] }.bind(null, r));
        return i
    }, n.n = function(t) { var e = t && t.__esModule ? function() { return t.default } : function() { return t }; return n.d(e, "a", e), e }, n.o = function(t, e) { return Object.prototype.hasOwnProperty.call(t, e) }, n.p = "", n(n.s = 485)
}({
    1: function(t, e) { t.exports = window.jQuery },
    10: function(t, e, n) {
        (function(t, e) {
            ! function(t, n) {
                "use strict";
                if (!t.setImmediate) {
                    var i, r, s, o, u, a = 1,
                        c = {},
                        l = !1,
                        h = t.document,
                        f = Object.getPrototypeOf && Object.getPrototypeOf(t);
                    f = f && f.setTimeout ? f : t, "[object process]" === {}.toString.call(t.process) ? i = function(t) { e.nextTick((function() { p(t) })) } : ! function() {
                        if (t.postMessage && !t.importScripts) {
                            var e = !0,
                                n = t.onmessage;
                            return t.onmessage = function() { e = !1 }, t.postMessage("", "*"), t.onmessage = n, e
                        }
                    }() ? t.MessageChannel ? ((s = new MessageChannel).port1.onmessage = function(t) { p(t.data) }, i = function(t) { s.port2.postMessage(t) }) : h && "onreadystatechange" in h.createElement("script") ? (r = h.documentElement, i = function(t) {
                        var e = h.createElement("script");
                        e.onreadystatechange = function() { p(t), e.onreadystatechange = null, r.removeChild(e), e = null }, r.appendChild(e)
                    }) : i = function(t) { setTimeout(p, 0, t) } : (o = "setImmediate$" + Math.random() + "$", u = function(e) { e.source === t && "string" == typeof e.data && 0 === e.data.indexOf(o) && p(+e.data.slice(o.length)) }, t.addEventListener ? t.addEventListener("message", u, !1) : t.attachEvent("onmessage", u), i = function(e) { t.postMessage(o + e, "*") }), f.setImmediate = function(t) { "function" != typeof t && (t = new Function("" + t)); for (var e = new Array(arguments.length - 1), n = 0; n < e.length; n++) e[n] = arguments[n + 1]; var r = { callback: t, args: e }; return c[a] = r, i(a), a++ }, f.clearImmediate = d
                }

                function d(t) { delete c[t] }

                function p(t) {
                    if (l) setTimeout(p, 0, t);
                    else {
                        var e = c[t];
                        if (e) {
                            l = !0;
                            try {
                                ! function(t) {
                                    var e = t.callback,
                                        n = t.args;
                                    switch (n.length) {
                                        case 0:
                                            e();
                                            break;
                                        case 1:
                                            e(n[0]);
                                            break;
                                        case 2:
                                            e(n[0], n[1]);
                                            break;
                                        case 3:
                                            e(n[0], n[1], n[2]);
                                            break;
                                        default:
                                            e.apply(void 0, n)
                                    }
                                }(e)
                            } finally { d(t), l = !1 }
                        }
                    }
                }
            }("undefined" == typeof self ? void 0 === t ? this : t : self)
        }).call(this, n(3), n(11))
    },
    11: function(t, e) {
        var n, i, r = t.exports = {};

        function s() { throw new Error("setTimeout has not been defined") }

        function o() { throw new Error("clearTimeout has not been defined") }

        function u(t) { if (n === setTimeout) return setTimeout(t, 0); if ((n === s || !n) && setTimeout) return n = setTimeout, setTimeout(t, 0); try { return n(t, 0) } catch (e) { try { return n.call(null, t, 0) } catch (e) { return n.call(this, t, 0) } } }! function() { try { n = "function" == typeof setTimeout ? setTimeout : s } catch (t) { n = s } try { i = "function" == typeof clearTimeout ? clearTimeout : o } catch (t) { i = o } }();
        var a, c = [],
            l = !1,
            h = -1;

        function f() { l && a && (l = !1, a.length ? c = a.concat(c) : h = -1, c.length && d()) }

        function d() {
            if (!l) {
                var t = u(f);
                l = !0;
                for (var e = c.length; e;) {
                    for (a = c, c = []; ++h < e;) a && a[h].run();
                    h = -1, e = c.length
                }
                a = null, l = !1,
                    function(t) { if (i === clearTimeout) return clearTimeout(t); if ((i === o || !i) && clearTimeout) return i = clearTimeout, clearTimeout(t); try { i(t) } catch (e) { try { return i.call(null, t) } catch (e) { return i.call(this, t) } } }(t)
            }
        }

        function p(t, e) { this.fun = t, this.array = e }

        function g() {}
        r.nextTick = function(t) {
            var e = new Array(arguments.length - 1);
            if (arguments.length > 1)
                for (var n = 1; n < arguments.length; n++) e[n - 1] = arguments[n];
            c.push(new p(t, e)), 1 !== c.length || l || u(d)
        }, p.prototype.run = function() { this.fun.apply(null, this.array) }, r.title = "browser", r.browser = !0, r.env = {}, r.argv = [], r.version = "", r.versions = {}, r.on = g, r.addListener = g, r.once = g, r.off = g, r.removeListener = g, r.removeAllListeners = g, r.emit = g, r.prependListener = g, r.prependOnceListener = g, r.listeners = function(t) { return [] }, r.binding = function(t) { throw new Error("process.binding is not supported") }, r.cwd = function() { return "/" }, r.chdir = function(t) { throw new Error("process.chdir is not supported") }, r.umask = function() { return 0 }
    },
    189: function(t, e, n) {
        (function(i) {
            var r, s, o;
            /*!
             * typeahead.js 0.11.1
             * https://github.com/twitter/typeahead.js
             * Copyright 2013-2015 Twitter, Inc. and other contributors; Licensed MIT
             */
            o = this, r = [n(1)], void 0 === (s = function(t) {
                return o.Bloodhound = (e = t, n = function() {
                    "use strict";
                    return {
                        isMsie: function() { return !!/(msie|trident)/i.test(navigator.userAgent) && navigator.userAgent.match(/(msie |rv:)(\d+(.\d+)?)/i)[2] },
                        isBlankString: function(t) { return !t || /^\s*$/.test(t) },
                        escapeRegExChars: function(t) { return t.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&") },
                        isString: function(t) { return "string" == typeof t },
                        isNumber: function(t) { return "number" == typeof t },
                        isArray: e.isArray,
                        isFunction: e.isFunction,
                        isObject: e.isPlainObject,
                        isUndefined: function(t) { return void 0 === t },
                        isElement: function(t) { return !(!t || 1 !== t.nodeType) },
                        isJQuery: function(t) { return t instanceof e },
                        toStr: function(t) { return n.isUndefined(t) || null === t ? "" : t + "" },
                        bind: e.proxy,
                        each: function(t, n) { e.each(t, (function(t, e) { return n(e, t) })) },
                        map: e.map,
                        filter: e.grep,
                        every: function(t, n) { var i = !0; return t ? (e.each(t, (function(e, r) { if (!(i = n.call(null, r, e, t))) return !1 })), !!i) : i },
                        some: function(t, n) { var i = !1; return t ? (e.each(t, (function(e, r) { if (i = n.call(null, r, e, t)) return !1 })), !!i) : i },
                        mixin: e.extend,
                        identity: function(t) { return t },
                        clone: function(t) { return e.extend(!0, {}, t) },
                        getIdGenerator: function() { var t = 0; return function() { return t++ } },
                        templatify: function(t) { return e.isFunction(t) ? t : function() { return String(t) } },
                        defer: function(t) { setTimeout(t, 0) },
                        debounce: function(t, e, n) {
                            var i, r;
                            return function() {
                                var s, o, u = this,
                                    a = arguments;
                                return s = function() { i = null, n || (r = t.apply(u, a)) }, o = n && !i, clearTimeout(i), i = setTimeout(s, e), o && (r = t.apply(u, a)), r
                            }
                        },
                        throttle: function(t, e) {
                            var n, i, r, s, o, u;
                            return o = 0, u = function() { o = new Date, r = null, s = t.apply(n, i) },
                                function() {
                                    var a = new Date,
                                        c = e - (a - o);
                                    return n = this, i = arguments, c <= 0 ? (clearTimeout(r), r = null, o = a, s = t.apply(n, i)) : r || (r = setTimeout(u, c)), s
                                }
                        },
                        stringify: function(t) { return n.isString(t) ? t : JSON.stringify(t) },
                        noop: function() {}
                    }
                }(), i = function() {
                    "use strict";
                    return { nonword: e, whitespace: t, obj: { nonword: i(e), whitespace: i(t) } };

                    function t(t) { return (t = n.toStr(t)) ? t.split(/\s+/) : [] }

                    function e(t) { return (t = n.toStr(t)) ? t.split(/\W+/) : [] }

                    function i(t) {
                        return function(e) {
                            return e = n.isArray(e) ? e : [].slice.call(arguments, 0),
                                function(i) { var r = []; return n.each(e, (function(e) { r = r.concat(t(n.toStr(i[e]))) })), r }
                        }
                    }
                }(), r = function() {
                    "use strict";

                    function t(t) { this.maxSize = n.isNumber(t) ? t : 100, this.reset(), this.maxSize <= 0 && (this.set = this.get = e.noop) }

                    function i() { this.head = this.tail = null }

                    function r(t, e) { this.key = t, this.val = e, this.prev = this.next = null }
                    return n.mixin(t.prototype, {
                        set: function(t, e) {
                            var n, i = this.list.tail;
                            this.size >= this.maxSize && (this.list.remove(i), delete this.hash[i.key], this.size--), (n = this.hash[t]) ? (n.val = e, this.list.moveToFront(n)) : (n = new r(t, e), this.list.add(n), this.hash[t] = n, this.size++)
                        },
                        get: function(t) { var e = this.hash[t]; if (e) return this.list.moveToFront(e), e.val },
                        reset: function() { this.size = 0, this.hash = {}, this.list = new i }
                    }), n.mixin(i.prototype, { add: function(t) { this.head && (t.next = this.head, this.head.prev = t), this.head = t, this.tail = this.tail || t }, remove: function(t) { t.prev ? t.prev.next = t.next : this.head = t.next, t.next ? t.next.prev = t.prev : this.tail = t.prev }, moveToFront: function(t) { this.remove(t), this.add(t) } }), t
                }(), s = function() {
                    "use strict";
                    var t;
                    try {
                        (t = window.localStorage).setItem("~~~", "!"), t.removeItem("~~~")
                    } catch (e) { t = null }

                    function i(e, i) { this.prefix = ["__", e, "__"].join(""), this.ttlKey = "__ttl__", this.keyMatcher = new RegExp("^" + n.escapeRegExChars(this.prefix)), this.ls = i || t, !this.ls && this._noop() }
                    return n.mixin(i.prototype, {
                        _prefix: function(t) { return this.prefix + t },
                        _ttlKey: function(t) { return this._prefix(t) + this.ttlKey },
                        _noop: function() { this.get = this.set = this.remove = this.clear = this.isExpired = n.noop },
                        _safeSet: function(t, e) { try { this.ls.setItem(t, e) } catch (t) { "QuotaExceededError" === t.name && (this.clear(), this._noop()) } },
                        get: function(t) { return this.isExpired(t) && this.remove(t), o(this.ls.getItem(this._prefix(t))) },
                        set: function(t, e, i) { return n.isNumber(i) ? this._safeSet(this._ttlKey(t), s(r() + i)) : this.ls.removeItem(this._ttlKey(t)), this._safeSet(this._prefix(t), s(e)) },
                        remove: function(t) { return this.ls.removeItem(this._ttlKey(t)), this.ls.removeItem(this._prefix(t)), this },
                        clear: function() {
                            var e, n = function(e) {
                                var n, i, r = [],
                                    s = t.length;
                                for (n = 0; n < s; n++)(i = t.key(n)).match(e) && r.push(i.replace(e, ""));
                                return r
                            }(this.keyMatcher);
                            for (e = n.length; e--;) this.remove(n[e]);
                            return this
                        },
                        isExpired: function(t) { var e = o(this.ls.getItem(this._ttlKey(t))); return !!(n.isNumber(e) && r() > e) }
                    }), i;

                    function r() { return (new Date).getTime() }

                    function s(t) { return JSON.stringify(n.isUndefined(t) ? null : t) }

                    function o(t) { return e.parseJSON(t) }
                }(), u = function() {
                    "use strict";
                    var t = 0,
                        i = {},
                        s = 6,
                        o = new r(10);

                    function u(t) { t = t || {}, this.cancelled = !1, this.lastReq = null, this._send = t.transport, this._get = t.limiter ? t.limiter(this._get) : this._get, this._cache = !1 === t.cache ? new r(0) : o }
                    return u.setMaxPendingRequests = function(t) { s = t }, u.resetCache = function() { o.reset() }, n.mixin(u.prototype, {
                        _fingerprint: function(t) { return (t = t || {}).url + t.type + e.param(t.data || {}) },
                        _get: function(e, n) {
                            var r, o, u = this;

                            function a(t) { n(null, t), u._cache.set(r, t) }

                            function c() { n(!0) }

                            function l() { t--, delete i[r], u.onDeckRequestArgs && (u._get.apply(u, u.onDeckRequestArgs), u.onDeckRequestArgs = null) }
                            r = this._fingerprint(e), this.cancelled || r !== this.lastReq || ((o = i[r]) ? o.done(a).fail(c) : t < s ? (t++, i[r] = this._send(e).done(a).fail(c).always(l)) : this.onDeckRequestArgs = [].slice.call(arguments, 0))
                        },
                        get: function(t, i) {
                            var r, s;
                            i = i || e.noop, t = n.isString(t) ? { url: t } : t || {}, s = this._fingerprint(t), this.cancelled = !1, this.lastReq = s, (r = this._cache.get(s)) ? i(null, r) : this._get(t, i)
                        },
                        cancel: function() { this.cancelled = !0 }
                    }), u
                }(), a = window.SearchIndex = function() {
                    "use strict";

                    function t(t) {
                        (t = t || {}).datumTokenizer && t.queryTokenizer || e.error("datumTokenizer and queryTokenizer are both required"), this.identify = t.identify || n.stringify, this.datumTokenizer = t.datumTokenizer, this.queryTokenizer = t.queryTokenizer, this.reset()
                    }
                    return n.mixin(t.prototype, {
                        bootstrap: function(t) { this.datums = t.datums, this.trie = t.trie },
                        add: function(t) {
                            var e = this;
                            t = n.isArray(t) ? t : [t], n.each(t, (function(t) {
                                var s, o;
                                e.datums[s = e.identify(t)] = t, o = i(e.datumTokenizer(t)), n.each(o, (function(t) { var n, i, o; for (n = e.trie, i = t.split(""); o = i.shift();)(n = n.c[o] || (n.c[o] = r())).i.push(s) }))
                            }))
                        },
                        get: function(t) { var e = this; return n.map(t, (function(t) { return e.datums[t] })) },
                        search: function(t) {
                            var e, r, s = this;
                            return e = i(this.queryTokenizer(t)), n.each(e, (function(t) {
                                var e, n, i, o;
                                if (r && 0 === r.length) return !1;
                                for (e = s.trie, n = t.split(""); e && (i = n.shift());) e = e.c[i];
                                if (!e || 0 !== n.length) return r = [], !1;
                                o = e.i.slice(0), r = r ? function(t, e) {
                                    var n = 0,
                                        i = 0,
                                        r = [];
                                    t = t.sort(), e = e.sort();
                                    for (var s = t.length, o = e.length; n < s && i < o;) t[n] < e[i] ? n++ : (t[n] > e[i] || (r.push(t[n]), n++), i++);
                                    return r
                                }(r, o) : o
                            })), r ? n.map(function(t) { for (var e = {}, n = [], i = 0, r = t.length; i < r; i++) e[t[i]] || (e[t[i]] = !0, n.push(t[i])); return n }(r), (function(t) { return s.datums[t] })) : []
                        },
                        all: function() { var t = []; for (var e in this.datums) t.push(this.datums[e]); return t },
                        reset: function() { this.datums = {}, this.trie = r() },
                        serialize: function() { return { datums: this.datums, trie: this.trie } }
                    }), t;

                    function i(t) { return t = n.filter(t, (function(t) { return !!t })), t = n.map(t, (function(t) { return t.toLowerCase() })) }

                    function r() { var t = { i: [], c: {} }; return t }
                }(), c = function() {
                    "use strict";
                    var t;

                    function e(t) { this.url = t.url, this.ttl = t.ttl, this.cache = t.cache, this.prepare = t.prepare, this.transform = t.transform, this.transport = t.transport, this.thumbprint = t.thumbprint, this.storage = new s(t.cacheKey) }
                    return t = { data: "data", protocol: "protocol", thumbprint: "thumbprint" }, n.mixin(e.prototype, {
                        _settings: function() { return { url: this.url, type: "GET", dataType: "json" } },
                        store: function(e) { this.cache && (this.storage.set(t.data, e, this.ttl), this.storage.set(t.protocol, location.protocol, this.ttl), this.storage.set(t.thumbprint, this.thumbprint, this.ttl)) },
                        fromCache: function() { var e, n = {}; return this.cache ? (n.data = this.storage.get(t.data), n.protocol = this.storage.get(t.protocol), n.thumbprint = this.storage.get(t.thumbprint), e = n.thumbprint !== this.thumbprint || n.protocol !== location.protocol, n.data && !e ? n.data : null) : null },
                        fromNetwork: function(t) {
                            var e, n = this;
                            t && (e = this.prepare(this._settings()), this.transport(e).fail((function() { t(!0) })).done((function(e) { t(null, n.transform(e)) })))
                        },
                        clear: function() { return this.storage.clear(), this }
                    }), e
                }(), l = function() {
                    "use strict";

                    function t(t) { this.url = t.url, this.prepare = t.prepare, this.transform = t.transform, this.transport = new u({ cache: t.cache, limiter: t.limiter, transport: t.transport }) }
                    return n.mixin(t.prototype, { _settings: function() { return { url: this.url, type: "GET", dataType: "json" } }, get: function(t, e) { var n, i = this; if (e) return t = t || "", n = this.prepare(t, this._settings()), this.transport.get(n, (function(t, n) { e(t ? [] : i.transform(n)) })) }, cancelLastRequest: function() { this.transport.cancel() } }), t
                }(), h = function() {
                    "use strict";
                    return function(i) { var r, s; return r = { initialize: !0, identify: n.stringify, datumTokenizer: null, queryTokenizer: null, sufficient: 5, sorter: null, local: [], prefetch: null, remote: null }, !(i = n.mixin(r, i || {})).datumTokenizer && e.error("datumTokenizer is required"), !i.queryTokenizer && e.error("queryTokenizer is required"), s = i.sorter, i.sorter = s ? function(t) { return t.sort(s) } : n.identity, i.local = n.isFunction(i.local) ? i.local() : i.local, i.prefetch = function(i) { var r; return i ? (r = { url: null, ttl: 864e5, cache: !0, cacheKey: null, thumbprint: "", prepare: n.identity, transform: n.identity, transport: null }, i = n.isString(i) ? { url: i } : i, !(i = n.mixin(r, i)).url && e.error("prefetch requires url to be set"), i.transform = i.filter || i.transform, i.cacheKey = i.cacheKey || i.url, i.thumbprint = "0.11.1" + i.thumbprint, i.transport = i.transport ? t(i.transport) : e.ajax, i) : null }(i.prefetch), i.remote = function(i) { var r; if (i) return r = { url: null, cache: !0, prepare: null, replace: null, wildcard: null, limiter: null, rateLimitBy: "debounce", rateLimitWait: 300, transform: n.identity, transport: null }, i = n.isString(i) ? { url: i } : i, !(i = n.mixin(r, i)).url && e.error("remote requires url to be set"), i.transform = i.filter || i.transform, i.prepare = function(t) { var e, n, i; return e = t.prepare, n = t.replace, i = t.wildcard, e || (e = n ? function(t, e) { return e.url = n(e.url, t), e } : t.wildcard ? function(t, e) { return e.url = e.url.replace(i, encodeURIComponent(t)), e } : function(t, e) { return e }) }(i), i.limiter = function(t) { var e, i, r; return e = t.limiter, i = t.rateLimitBy, r = t.rateLimitWait, e || (e = /^throttle$/i.test(i) ? function(t) { return function(e) { return n.throttle(e, t) } }(r) : function(t) { return function(e) { return n.debounce(e, t) } }(r)), e }(i), i.transport = i.transport ? t(i.transport) : e.ajax, delete i.replace, delete i.wildcard, delete i.rateLimitBy, delete i.rateLimitWait, i }(i.remote), i };

                    function t(t) { return function(i) { var r = e.Deferred(); return t(i, (function(t) { n.defer((function() { r.resolve(t) })) }), (function(t) { n.defer((function() { r.reject(t) })) })), r } }
                }(), function() {
                    "use strict";
                    var t;

                    function r(t) { t = h(t), this.sorter = t.sorter, this.identify = t.identify, this.sufficient = t.sufficient, this.local = t.local, this.remote = t.remote ? new l(t.remote) : null, this.prefetch = t.prefetch ? new c(t.prefetch) : null, this.index = new a({ identify: this.identify, datumTokenizer: t.datumTokenizer, queryTokenizer: t.queryTokenizer }), !1 !== t.initialize && this.initialize() }
                    return t = window && window.Bloodhound, r.noConflict = function() { return window && (window.Bloodhound = t), r }, r.tokenizers = i, n.mixin(r.prototype, {
                        __ttAdapter: function() { var t = this; return this.remote ? function(e, n, i) { return t.search(e, n, i) } : function(e, n) { return t.search(e, n) } },
                        _loadPrefetch: function() {
                            var t, n, i = this;
                            return t = e.Deferred(), this.prefetch ? (n = this.prefetch.fromCache()) ? (this.index.bootstrap(n), t.resolve()) : this.prefetch.fromNetwork((function(e, n) {
                                if (e) return t.reject();
                                i.add(n), i.prefetch.store(i.index.serialize()), t.resolve()
                            })) : t.resolve(), t.promise()
                        },
                        _initialize: function() { var t = this; return this.clear(), (this.initPromise = this._loadPrefetch()).done((function() { t.add(t.local) })), this.initPromise },
                        initialize: function(t) { return !this.initPromise || t ? this._initialize() : this.initPromise },
                        add: function(t) { return this.index.add(t), this },
                        get: function(t) { return t = n.isArray(t) ? t : [].slice.call(arguments), this.index.get(t) },
                        search: function(t, e, i) {
                            var r, s = this;
                            return r = this.sorter(this.index.search(t)), e(this.remote ? r.slice() : r), this.remote && r.length < this.sufficient ? this.remote.get(t, (function(t) {
                                var e = [];
                                n.each(t, (function(t) {!n.some(r, (function(e) { return s.identify(t) === s.identify(e) })) && e.push(t) })), i && i(e)
                            })) : this.remote && this.remote.cancelLastRequest(), this
                        },
                        all: function() { return this.index.all() },
                        clear: function() { return this.index.reset(), this },
                        clearPrefetchCache: function() { return this.prefetch && this.prefetch.clear(), this },
                        clearRemoteCache: function() { return u.resetCache(), this },
                        ttAdapter: function() { return this.__ttAdapter() }
                    }), r
                }());
                var e, n, i, r, s, u, a, c, l, h
            }.apply(e, r)) || (t.exports = s), r = [n(1)], void 0 === (s = function(t) {
                return e = t, n = function() {
                    "use strict";
                    return {
                        isMsie: function() { return !!/(msie|trident)/i.test(navigator.userAgent) && navigator.userAgent.match(/(msie |rv:)(\d+(.\d+)?)/i)[2] },
                        isBlankString: function(t) { return !t || /^\s*$/.test(t) },
                        escapeRegExChars: function(t) { return t.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&") },
                        isString: function(t) { return "string" == typeof t },
                        isNumber: function(t) { return "number" == typeof t },
                        isArray: e.isArray,
                        isFunction: e.isFunction,
                        isObject: e.isPlainObject,
                        isUndefined: function(t) { return void 0 === t },
                        isElement: function(t) { return !(!t || 1 !== t.nodeType) },
                        isJQuery: function(t) { return t instanceof e },
                        toStr: function(t) { return n.isUndefined(t) || null === t ? "" : t + "" },
                        bind: e.proxy,
                        each: function(t, n) { e.each(t, (function(t, e) { return n(e, t) })) },
                        map: e.map,
                        filter: e.grep,
                        every: function(t, n) { var i = !0; return t ? (e.each(t, (function(e, r) { if (!(i = n.call(null, r, e, t))) return !1 })), !!i) : i },
                        some: function(t, n) { var i = !1; return t ? (e.each(t, (function(e, r) { if (i = n.call(null, r, e, t)) return !1 })), !!i) : i },
                        mixin: e.extend,
                        identity: function(t) { return t },
                        clone: function(t) { return e.extend(!0, {}, t) },
                        getIdGenerator: function() { var t = 0; return function() { return t++ } },
                        templatify: function(t) { return e.isFunction(t) ? t : function() { return String(t) } },
                        defer: function(t) { setTimeout(t, 0) },
                        debounce: function(t, e, n) {
                            var i, r;
                            return function() {
                                var s, o, u = this,
                                    a = arguments;
                                return s = function() { i = null, n || (r = t.apply(u, a)) }, o = n && !i, clearTimeout(i), i = setTimeout(s, e), o && (r = t.apply(u, a)), r
                            }
                        },
                        throttle: function(t, e) {
                            var n, i, r, s, o, u;
                            return o = 0, u = function() { o = new Date, r = null, s = t.apply(n, i) },
                                function() {
                                    var a = new Date,
                                        c = e - (a - o);
                                    return n = this, i = arguments, c <= 0 ? (clearTimeout(r), r = null, o = a, s = t.apply(n, i)) : r || (r = setTimeout(u, c)), s
                                }
                        },
                        stringify: function(t) { return n.isString(t) ? t : JSON.stringify(t) },
                        noop: function() {}
                    }
                }(), r = function() {
                    "use strict";
                    var t = { wrapper: "twitter-typeahead", input: "tt-input", hint: "tt-hint", menu: "tt-menu", dataset: "tt-dataset", suggestion: "tt-suggestion", selectable: "tt-selectable", empty: "tt-empty", open: "tt-open", cursor: "tt-cursor", highlight: "tt-highlight" };
                    return function(i) { var r, s, o, u; return s = n.mixin({}, t, i), { css: (r = { css: (u = { wrapper: { position: "relative", display: "inline-block" }, hint: { position: "absolute", top: "0", left: "0", borderColor: "transparent", boxShadow: "none", opacity: "1" }, input: { position: "relative", verticalAlign: "top", backgroundColor: "transparent" }, inputWithNoHint: { position: "relative", verticalAlign: "top" }, menu: { position: "absolute", top: "100%", left: "0", zIndex: "100", display: "none" }, ltr: { left: "0", right: "auto" }, rtl: { left: "auto", right: " 0" } }, n.isMsie() && n.mixin(u.input, { backgroundImage: "url(data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///yH5BAEAAAAALAAAAAABAAEAAAIBRAA7)" }), u), classes: s, html: (o = s, { wrapper: '<span class="' + o.wrapper + '"></span>', menu: '<div class="' + o.menu + '"></div>' }), selectors: e(s) }).css, html: r.html, classes: r.classes, selectors: r.selectors, mixin: function(t) { n.mixin(t, r) } } };

                    function e(t) { var e = {}; return n.each(t, (function(t, n) { e[n] = "." + t })), e }
                }(), s = function() {
                    "use strict";
                    var t;

                    function i(t) { t && t.el || e.error("EventBus initialized without el"), this.$el = e(t.el) }
                    return t = { render: "rendered", cursorchange: "cursorchanged", select: "selected", autocomplete: "autocompleted" }, n.mixin(i.prototype, {
                        _trigger: function(t, n) { var i; return i = e.Event("typeahead:" + t), (n = n || []).unshift(i), this.$el.trigger.apply(this.$el, n), i },
                        before: function(t) { var e; return e = [].slice.call(arguments, 1), this._trigger("before" + t, e).isDefaultPrevented() },
                        trigger: function(e) {
                            var n;
                            this._trigger(e, [].slice.call(arguments, 1)), (n = t[e]) && this._trigger(n, [].slice.call(arguments, 1))
                        }
                    }), i
                }(), o = function() {
                    "use strict";
                    var t = /\s+/,
                        e = window.setImmediate ? function(t) { i((function() { t() })) } : function(t) { setTimeout((function() { t() }), 0) };
                    return {
                        onSync: function(t, e, i) { return n.call(this, "sync", t, e, i) },
                        onAsync: function(t, e, i) { return n.call(this, "async", t, e, i) },
                        off: function(e) { var n; if (!this._callbacks) return this; for (e = e.split(t); n = e.shift();) delete this._callbacks[n]; return this },
                        trigger: function(n) {
                            var i, s, o, u, a;
                            if (!this._callbacks) return this;
                            for (n = n.split(t), o = [].slice.call(arguments, 1);
                                (i = n.shift()) && (s = this._callbacks[i]);) u = r(s.sync, this, [i].concat(o)), a = r(s.async, this, [i].concat(o)), u() && e(a);
                            return this
                        }
                    };

                    function n(e, n, i, r) { var s; if (!i) return this; for (n = n.split(t), i = r ? function(t, e) { return t.bind ? t.bind(e) : function() { t.apply(e, [].slice.call(arguments, 0)) } }(i, r) : i, this._callbacks = this._callbacks || {}; s = n.shift();) this._callbacks[s] = this._callbacks[s] || { sync: [], async: [] }, this._callbacks[s][e].push(i); return this }

                    function r(t, e, n) { return function() { for (var i, r = 0, s = t.length; !i && r < s; r += 1) i = !1 === t[r].apply(e, n); return !i } }
                }(), u = function(t) {
                    "use strict";
                    var e = { node: null, pattern: null, tagName: "strong", className: null, wordsOnly: !1, caseSensitive: !1 };
                    return function(i) {
                        var r;
                        (i = n.mixin({}, e, i)).node && i.pattern && (i.pattern = n.isArray(i.pattern) ? i.pattern : [i.pattern], r = function(t, e, i) { for (var r, s = [], o = 0, u = t.length; o < u; o++) s.push(n.escapeRegExChars(t[o])); return r = i ? "\\b(" + s.join("|") + ")\\b" : "(" + s.join("|") + ")", e ? new RegExp(r) : new RegExp(r, "i") }(i.pattern, i.caseSensitive, i.wordsOnly), function t(e, n) { for (var i, r = 0; r < e.childNodes.length; r++) 3 === (i = e.childNodes[r]).nodeType ? r += n(i) ? 1 : 0 : t(i, n) }(i.node, (function(e) { var n, s, o; return (n = r.exec(e.data)) && (o = t.createElement(i.tagName), i.className && (o.className = i.className), (s = e.splitText(n.index)).splitText(n[0].length), o.appendChild(s.cloneNode(!0)), e.parentNode.replaceChild(o, s)), !!n })))
                    }
                }(window.document), a = function() {
                    "use strict";
                    var t;

                    function i(t, i) {
                        var r;
                        (t = t || {}).input || e.error("input is missing"), i.mixin(this), this.$hint = e(t.hint), this.$input = e(t.input), this.query = this.$input.val(), this.queryWhenFocused = this.hasFocus() ? this.query : null, this.$overflowHelper = (r = this.$input, e('<pre aria-hidden="true"></pre>').css({ position: "absolute", visibility: "hidden", whiteSpace: "pre", fontFamily: r.css("font-family"), fontSize: r.css("font-size"), fontStyle: r.css("font-style"), fontVariant: r.css("font-variant"), fontWeight: r.css("font-weight"), wordSpacing: r.css("word-spacing"), letterSpacing: r.css("letter-spacing"), textIndent: r.css("text-indent"), textRendering: r.css("text-rendering"), textTransform: r.css("text-transform") }).insertAfter(r)), this._checkLanguageDirection(), 0 === this.$hint.length && (this.setHint = this.getHint = this.clearHint = this.clearHintIfInvalid = n.noop)
                    }
                    return t = { 9: "tab", 27: "esc", 37: "left", 39: "right", 13: "enter", 38: "up", 40: "down" }, i.normalizeQuery = function(t) { return n.toStr(t).replace(/^\s*/g, "").replace(/\s{2,}/g, " ") }, n.mixin(i.prototype, o, {
                        _onBlur: function() { this.resetInputValue(), this.trigger("blurred") },
                        _onFocus: function() { this.queryWhenFocused = this.query, this.trigger("focused") },
                        _onKeydown: function(e) {
                            var n = t[e.which || e.keyCode];
                            this._managePreventDefault(n, e), n && this._shouldTrigger(n, e) && this.trigger(n + "Keyed", e)
                        },
                        _onInput: function() { this._setQuery(this.getInputValue()), this.clearHintIfInvalid(), this._checkLanguageDirection() },
                        _managePreventDefault: function(t, e) {
                            var n;
                            switch (t) {
                                case "up":
                                case "down":
                                    n = !r(e);
                                    break;
                                default:
                                    n = !1
                            }
                            n && e.preventDefault()
                        },
                        _shouldTrigger: function(t, e) {
                            var n;
                            switch (t) {
                                case "tab":
                                    n = !r(e);
                                    break;
                                default:
                                    n = !0
                            }
                            return n
                        },
                        _checkLanguageDirection: function() {
                            var t = (this.$input.css("direction") || "ltr").toLowerCase();
                            this.dir !== t && (this.dir = t, this.$hint.attr("dir", t), this.trigger("langDirChanged", t))
                        },
                        _setQuery: function(t, e) {
                            var n, r, s, o;
                            s = t, o = this.query, r = !!(n = i.normalizeQuery(s) === i.normalizeQuery(o)) && this.query.length !== t.length, this.query = t, e || n ? !e && r && this.trigger("whitespaceChanged", this.query) : this.trigger("queryChanged", this.query)
                        },
                        bind: function() { var e, i, r, s, o = this; return e = n.bind(this._onBlur, this), i = n.bind(this._onFocus, this), r = n.bind(this._onKeydown, this), s = n.bind(this._onInput, this), this.$input.on("blur.tt", e).on("focus.tt", i).on("keydown.tt", r), !n.isMsie() || n.isMsie() > 9 ? this.$input.on("input.tt", s) : this.$input.on("keydown.tt keypress.tt cut.tt paste.tt", (function(e) { t[e.which || e.keyCode] || n.defer(n.bind(o._onInput, o, e)) })), this },
                        focus: function() { this.$input.focus() },
                        blur: function() { this.$input.blur() },
                        getLangDir: function() { return this.dir },
                        getQuery: function() { return this.query || "" },
                        setQuery: function(t, e) { this.setInputValue(t), this._setQuery(t, e) },
                        hasQueryChangedSinceLastFocus: function() { return this.query !== this.queryWhenFocused },
                        getInputValue: function() { return this.$input.val() },
                        setInputValue: function(t) { this.$input.val(t), this.clearHintIfInvalid(), this._checkLanguageDirection() },
                        resetInputValue: function() { this.setInputValue(this.query) },
                        getHint: function() { return this.$hint.val() },
                        setHint: function(t) { this.$hint.val(t) },
                        clearHint: function() { this.setHint("") },
                        clearHintIfInvalid: function() {
                            var t, e, n;
                            n = (t = this.getInputValue()) !== (e = this.getHint()) && 0 === e.indexOf(t), ("" === t || !n || this.hasOverflow()) && this.clearHint()
                        },
                        hasFocus: function() { return this.$input.is(":focus") },
                        hasOverflow: function() { var t = this.$input.width() - 2; return this.$overflowHelper.text(this.getInputValue()), this.$overflowHelper.width() >= t },
                        isCursorAtEnd: function() { var t, e, i; return t = this.$input.val().length, e = this.$input[0].selectionStart, n.isNumber(e) ? e === t : !document.selection || ((i = document.selection.createRange()).moveStart("character", -t), t === i.text.length) },
                        destroy: function() { this.$hint.off(".tt"), this.$input.off(".tt"), this.$overflowHelper.remove(), this.$hint = this.$input = this.$overflowHelper = e("<div>") }
                    }), i;

                    function r(t) { return t.altKey || t.ctrlKey || t.metaKey || t.shiftKey }
                }(), c = function() {
                    "use strict";
                    var t, i;

                    function r(t, r) {
                        var s, o, u, a;
                        (t = t || {}).templates = t.templates || {}, t.templates.notFound = t.templates.notFound || t.templates.empty, t.source || e.error("missing source"), t.node || e.error("missing node"), t.name && (s = t.name, !/^[_a-zA-Z0-9-]+$/.test(s)) && e.error("invalid dataset name: " + t.name), r.mixin(this), this.highlight = !!t.highlight, this.name = t.name || i(), this.limit = t.limit || 5, this.displayFn = (o = (o = t.display || t.displayKey) || n.stringify, n.isFunction(o) ? o : function(t) { return t[o] }), this.templates = (u = t.templates, a = this.displayFn, { notFound: u.notFound && n.templatify(u.notFound), pending: u.pending && n.templatify(u.pending), header: u.header && n.templatify(u.header), footer: u.footer && n.templatify(u.footer), suggestion: u.suggestion || function(t) { return e("<div>").text(a(t)) } }), this.source = t.source.__ttAdapter ? t.source.__ttAdapter() : t.source, this.async = n.isUndefined(t.async) ? this.source.length > 2 : !!t.async, this._resetLastSuggestion(), this.$el = e(t.node).addClass(this.classes.dataset).addClass(this.classes.dataset + "-" + this.name)
                    }
                    return t = { val: "tt-selectable-display", obj: "tt-selectable-object" }, i = n.getIdGenerator(), r.extractData = function(n) { var i = e(n); return i.data(t.obj) ? { val: i.data(t.val) || "", obj: i.data(t.obj) || null } : null }, n.mixin(r.prototype, o, {
                        _overwrite: function(t, e) {
                            (e = e || []).length ? this._renderSuggestions(t, e) : this.async && this.templates.pending ? this._renderPending(t) : !this.async && this.templates.notFound ? this._renderNotFound(t) : this._empty(), this.trigger("rendered", this.name, e, !1)
                        },
                        _append: function(t, e) {
                            (e = e || []).length && this.$lastSuggestion.length ? this._appendSuggestions(t, e) : e.length ? this._renderSuggestions(t, e) : !this.$lastSuggestion.length && this.templates.notFound && this._renderNotFound(t), this.trigger("rendered", this.name, e, !0)
                        },
                        _renderSuggestions: function(t, e) {
                            var n;
                            n = this._getSuggestionsFragment(t, e), this.$lastSuggestion = n.children().last(), this.$el.html(n).prepend(this._getHeader(t, e)).append(this._getFooter(t, e))
                        },
                        _appendSuggestions: function(t, e) {
                            var n, i;
                            i = (n = this._getSuggestionsFragment(t, e)).children().last(), this.$lastSuggestion.after(n), this.$lastSuggestion = i
                        },
                        _renderPending: function(t) {
                            var e = this.templates.pending;
                            this._resetLastSuggestion(), e && this.$el.html(e({ query: t, dataset: this.name }))
                        },
                        _renderNotFound: function(t) {
                            var e = this.templates.notFound;
                            this._resetLastSuggestion(), e && this.$el.html(e({ query: t, dataset: this.name }))
                        },
                        _empty: function() { this.$el.empty(), this._resetLastSuggestion() },
                        _getSuggestionsFragment: function(i, r) {
                            var s, o = this;
                            return s = document.createDocumentFragment(), n.each(r, (function(n) {
                                var r, u;
                                u = o._injectQuery(i, n), r = e(o.templates.suggestion(u)).data(t.obj, n).data(t.val, o.displayFn(n)).addClass(o.classes.suggestion + " " + o.classes.selectable), s.appendChild(r[0])
                            })), this.highlight && u({ className: this.classes.highlight, node: s, pattern: i }), e(s)
                        },
                        _getFooter: function(t, e) { return this.templates.footer ? this.templates.footer({ query: t, suggestions: e, dataset: this.name }) : null },
                        _getHeader: function(t, e) { return this.templates.header ? this.templates.header({ query: t, suggestions: e, dataset: this.name }) : null },
                        _resetLastSuggestion: function() { this.$lastSuggestion = e() },
                        _injectQuery: function(t, e) { return n.isObject(e) ? n.mixin({ _query: t }, e) : e },
                        update: function(t) {
                            var n = this,
                                i = !1,
                                r = !1,
                                s = 0;

                            function o(e) { r || (r = !0, e = (e || []).slice(0, n.limit), s = e.length, n._overwrite(t, e), s < n.limit && n.async && n.trigger("asyncRequested", t)) }
                            this.cancel(), this.cancel = function() { i = !0, n.cancel = e.noop, n.async && n.trigger("asyncCanceled", t) }, this.source(t, o, (function(r) { r = r || [], !i && s < n.limit && (n.cancel = e.noop, s += r.length, n._append(t, r.slice(0, n.limit - s)), n.async && n.trigger("asyncReceived", t)) })), !r && o([])
                        },
                        cancel: e.noop,
                        clear: function() { this._empty(), this.cancel(), this.trigger("cleared") },
                        isEmpty: function() { return this.$el.is(":empty") },
                        destroy: function() { this.$el = e("<div>") }
                    }), r
                }(), l = function() {
                    "use strict";

                    function t(t, i) {
                        var r = this;
                        (t = t || {}).node || e.error("node is required"), i.mixin(this), this.$node = e(t.node), this.query = null, this.datasets = n.map(t.datasets, (function(t) { var n = r.$node.find(t.node).first(); return t.node = n.length ? n : e("<div>").appendTo(r.$node), new c(t, i) }))
                    }
                    return n.mixin(t.prototype, o, {
                        _onSelectableClick: function(t) { this.trigger("selectableClicked", e(t.currentTarget)) },
                        _onRendered: function(t, e, n, i) { this.$node.toggleClass(this.classes.empty, this._allDatasetsEmpty()), this.trigger("datasetRendered", e, n, i) },
                        _onCleared: function() { this.$node.toggleClass(this.classes.empty, this._allDatasetsEmpty()), this.trigger("datasetCleared") },
                        _propagate: function() { this.trigger.apply(this, arguments) },
                        _allDatasetsEmpty: function() { return n.every(this.datasets, (function(t) { return t.isEmpty() })) },
                        _getSelectables: function() { return this.$node.find(this.selectors.selectable) },
                        _removeCursor: function() {
                            var t = this.getActiveSelectable();
                            t && t.removeClass(this.classes.cursor)
                        },
                        _ensureVisible: function(t) {
                            var e, n, i, r;
                            n = (e = t.position().top) + t.outerHeight(!0), i = this.$node.scrollTop(), r = this.$node.height() + parseInt(this.$node.css("paddingTop"), 10) + parseInt(this.$node.css("paddingBottom"), 10), e < 0 ? this.$node.scrollTop(i + e) : r < n && this.$node.scrollTop(i + (n - r))
                        },
                        bind: function() { var t, e = this; return t = n.bind(this._onSelectableClick, this), this.$node.on("click.tt", this.selectors.selectable, t), n.each(this.datasets, (function(t) { t.onSync("asyncRequested", e._propagate, e).onSync("asyncCanceled", e._propagate, e).onSync("asyncReceived", e._propagate, e).onSync("rendered", e._onRendered, e).onSync("cleared", e._onCleared, e) })), this },
                        isOpen: function() { return this.$node.hasClass(this.classes.open) },
                        open: function() { this.$node.addClass(this.classes.open) },
                        close: function() { this.$node.removeClass(this.classes.open), this._removeCursor() },
                        setLanguageDirection: function(t) { this.$node.attr("dir", t) },
                        selectableRelativeToCursor: function(t) { var e, n, i; return n = this.getActiveSelectable(), e = this._getSelectables(), -1 === (i = (i = ((i = (n ? e.index(n) : -1) + t) + 1) % (e.length + 1) - 1) < -1 ? e.length - 1 : i) ? null : e.eq(i) },
                        setCursor: function(t) { this._removeCursor(), (t = t && t.first()) && (t.addClass(this.classes.cursor), this._ensureVisible(t)) },
                        getSelectableData: function(t) { return t && t.length ? c.extractData(t) : null },
                        getActiveSelectable: function() { var t = this._getSelectables().filter(this.selectors.cursor).first(); return t.length ? t : null },
                        getTopSelectable: function() { var t = this._getSelectables().first(); return t.length ? t : null },
                        update: function(t) { var e = t !== this.query; return e && (this.query = t, n.each(this.datasets, (function(e) { e.update(t) }))), e },
                        empty: function() { n.each(this.datasets, (function(t) { t.clear() })), this.query = null, this.$node.addClass(this.classes.empty) },
                        destroy: function() { this.$node.off(".tt"), this.$node = e("<div>"), n.each(this.datasets, (function(t) { t.destroy() })) }
                    }), t
                }(), h = function() {
                    "use strict";
                    var t = l.prototype;

                    function e() { l.apply(this, [].slice.call(arguments, 0)) }
                    return n.mixin(e.prototype, l.prototype, { open: function() { return !this._allDatasetsEmpty() && this._show(), t.open.apply(this, [].slice.call(arguments, 0)) }, close: function() { return this._hide(), t.close.apply(this, [].slice.call(arguments, 0)) }, _onRendered: function() { return this._allDatasetsEmpty() ? this._hide() : this.isOpen() && this._show(), t._onRendered.apply(this, [].slice.call(arguments, 0)) }, _onCleared: function() { return this._allDatasetsEmpty() ? this._hide() : this.isOpen() && this._show(), t._onCleared.apply(this, [].slice.call(arguments, 0)) }, setLanguageDirection: function(e) { return this.$node.css("ltr" === e ? this.css.ltr : this.css.rtl), t.setLanguageDirection.apply(this, [].slice.call(arguments, 0)) }, _hide: function() { this.$node.hide() }, _show: function() { this.$node.css("display", "block") } }), e
                }(), f = function() {
                    "use strict";

                    function t(t, r) {
                        var s, o, u, a, c, l, h, f, d, p, g;
                        (t = t || {}).input || e.error("missing input"), t.menu || e.error("missing menu"), t.eventBus || e.error("missing event bus"), r.mixin(this), this.eventBus = t.eventBus, this.minLength = n.isNumber(t.minLength) ? t.minLength : 1, this.input = t.input, this.menu = t.menu, this.enabled = !0, this.active = !1, this.input.hasFocus() && this.activate(), this.dir = this.input.getLangDir(), this._hacks(), this.menu.bind().onSync("selectableClicked", this._onSelectableClicked, this).onSync("asyncRequested", this._onAsyncRequested, this).onSync("asyncCanceled", this._onAsyncCanceled, this).onSync("asyncReceived", this._onAsyncReceived, this).onSync("datasetRendered", this._onDatasetRendered, this).onSync("datasetCleared", this._onDatasetCleared, this), s = i(this, "activate", "open", "_onFocused"), o = i(this, "deactivate", "_onBlurred"), u = i(this, "isActive", "isOpen", "_onEnterKeyed"), a = i(this, "isActive", "isOpen", "_onTabKeyed"), c = i(this, "isActive", "_onEscKeyed"), l = i(this, "isActive", "open", "_onUpKeyed"), h = i(this, "isActive", "open", "_onDownKeyed"), f = i(this, "isActive", "isOpen", "_onLeftKeyed"), d = i(this, "isActive", "isOpen", "_onRightKeyed"), p = i(this, "_openIfActive", "_onQueryChanged"), g = i(this, "_openIfActive", "_onWhitespaceChanged"), this.input.bind().onSync("focused", s, this).onSync("blurred", o, this).onSync("enterKeyed", u, this).onSync("tabKeyed", a, this).onSync("escKeyed", c, this).onSync("upKeyed", l, this).onSync("downKeyed", h, this).onSync("leftKeyed", f, this).onSync("rightKeyed", d, this).onSync("queryChanged", p, this).onSync("whitespaceChanged", g, this).onSync("langDirChanged", this._onLangDirChanged, this)
                    }
                    return n.mixin(t.prototype, {
                        _hacks: function() {
                            var t, i;
                            t = this.input.$input || e("<div>"), i = this.menu.$node || e("<div>"), t.on("blur.tt", (function(e) {
                                var r, s, o;
                                r = document.activeElement, s = i.is(r), o = i.has(r).length > 0, n.isMsie() && (s || o) && (e.preventDefault(), e.stopImmediatePropagation(), n.defer((function() { t.focus() })))
                            })), i.on("mousedown.tt", (function(t) { t.preventDefault() }))
                        },
                        _onSelectableClicked: function(t, e) { this.select(e) },
                        _onDatasetCleared: function() { this._updateHint() },
                        _onDatasetRendered: function(t, e, n, i) { this._updateHint(), this.eventBus.trigger("render", n, i, e) },
                        _onAsyncRequested: function(t, e, n) { this.eventBus.trigger("asyncrequest", n, e) },
                        _onAsyncCanceled: function(t, e, n) { this.eventBus.trigger("asynccancel", n, e) },
                        _onAsyncReceived: function(t, e, n) { this.eventBus.trigger("asyncreceive", n, e) },
                        _onFocused: function() { this._minLengthMet() && this.menu.update(this.input.getQuery()) },
                        _onBlurred: function() { this.input.hasQueryChangedSinceLastFocus() && this.eventBus.trigger("change", this.input.getQuery()) },
                        _onEnterKeyed: function(t, e) {
                            var n;
                            (n = this.menu.getActiveSelectable()) && this.select(n) && e.preventDefault()
                        },
                        _onTabKeyed: function(t, e) {
                            var n;
                            (n = this.menu.getActiveSelectable()) ? this.select(n) && e.preventDefault(): (n = this.menu.getTopSelectable()) && this.autocomplete(n) && e.preventDefault()
                        },
                        _onEscKeyed: function() { this.close() },
                        _onUpKeyed: function() { this.moveCursor(-1) },
                        _onDownKeyed: function() { this.moveCursor(1) },
                        _onLeftKeyed: function() { "rtl" === this.dir && this.input.isCursorAtEnd() && this.autocomplete(this.menu.getTopSelectable()) },
                        _onRightKeyed: function() { "ltr" === this.dir && this.input.isCursorAtEnd() && this.autocomplete(this.menu.getTopSelectable()) },
                        _onQueryChanged: function(t, e) { this._minLengthMet(e) ? this.menu.update(e) : this.menu.empty() },
                        _onWhitespaceChanged: function() { this._updateHint() },
                        _onLangDirChanged: function(t, e) { this.dir !== e && (this.dir = e, this.menu.setLanguageDirection(e)) },
                        _openIfActive: function() { this.isActive() && this.open() },
                        _minLengthMet: function(t) { return (t = n.isString(t) ? t : this.input.getQuery() || "").length >= this.minLength },
                        _updateHint: function() {
                            var t, e, i, r, s, o;
                            t = this.menu.getTopSelectable(), e = this.menu.getSelectableData(t), i = this.input.getInputValue(), !e || n.isBlankString(i) || this.input.hasOverflow() ? this.input.clearHint() : (r = a.normalizeQuery(i), s = n.escapeRegExChars(r), (o = new RegExp("^(?:" + s + ")(.+$)", "i").exec(e.val)) && this.input.setHint(i + o[1]))
                        },
                        isEnabled: function() { return this.enabled },
                        enable: function() { this.enabled = !0 },
                        disable: function() { this.enabled = !1 },
                        isActive: function() { return this.active },
                        activate: function() { return !!this.isActive() || !(!this.isEnabled() || this.eventBus.before("active")) && (this.active = !0, this.eventBus.trigger("active"), !0) },
                        deactivate: function() { return !this.isActive() || !this.eventBus.before("idle") && (this.active = !1, this.close(), this.eventBus.trigger("idle"), !0) },
                        isOpen: function() { return this.menu.isOpen() },
                        open: function() { return this.isOpen() || this.eventBus.before("open") || (this.menu.open(), this._updateHint(), this.eventBus.trigger("open")), this.isOpen() },
                        close: function() { return this.isOpen() && !this.eventBus.before("close") && (this.menu.close(), this.input.clearHint(), this.input.resetInputValue(), this.eventBus.trigger("close")), !this.isOpen() },
                        setVal: function(t) { this.input.setQuery(n.toStr(t)) },
                        getVal: function() { return this.input.getQuery() },
                        select: function(t) { var e = this.menu.getSelectableData(t); return !(!e || this.eventBus.before("select", e.obj) || (this.input.setQuery(e.val, !0), this.eventBus.trigger("select", e.obj), this.close(), 0)) },
                        autocomplete: function(t) { var e, n; return e = this.input.getQuery(), !(!(n = this.menu.getSelectableData(t)) || e === n.val || this.eventBus.before("autocomplete", n.obj) || (this.input.setQuery(n.val), this.eventBus.trigger("autocomplete", n.obj), 0)) },
                        moveCursor: function(t) { var e, n, i, r; return e = this.input.getQuery(), n = this.menu.selectableRelativeToCursor(t), r = (i = this.menu.getSelectableData(n)) ? i.obj : null, !(this._minLengthMet() && this.menu.update(e) || this.eventBus.before("cursorchange", r) || (this.menu.setCursor(n), i ? this.input.setInputValue(i.val) : (this.input.resetInputValue(), this._updateHint()), this.eventBus.trigger("cursorchange", r), 0)) },
                        destroy: function() { this.input.destroy(), this.menu.destroy() }
                    }), t;

                    function i(t) {
                        var e = [].slice.call(arguments, 1);
                        return function() {
                            var i = [].slice.call(arguments);
                            n.each(e, (function(e) { return t[e].apply(t, i) }))
                        }
                    }
                }(), void

                function() {
                    "use strict";
                    var t, i, o;

                    function u(t, n) {
                        t.each((function() {
                            var t, r = e(this);
                            (t = r.data(i.typeahead)) && n(t, r)
                        }))
                    }

                    function c(t, e) { return t.clone().addClass(e.classes.hint).removeData().css(e.css.hint).css((n = t, { backgroundAttachment: n.css("background-attachment"), backgroundClip: n.css("background-clip"), backgroundColor: n.css("background-color"), backgroundImage: n.css("background-image"), backgroundOrigin: n.css("background-origin"), backgroundPosition: n.css("background-position"), backgroundRepeat: n.css("background-repeat"), backgroundSize: n.css("background-size") })).prop("readonly", !0).removeAttr("id name placeholder required").attr({ autocomplete: "off", spellcheck: "false", tabindex: -1 }); var n }

                    function d(t, e) { t.data(i.attrs, { dir: t.attr("dir"), autocomplete: t.attr("autocomplete"), spellcheck: t.attr("spellcheck"), style: t.attr("style") }), t.addClass(e.classes.input).attr({ autocomplete: "off", spellcheck: !1 }); try {!t.attr("dir") && t.attr("dir", "auto") } catch (t) {} return t }

                    function p(t) { var i; return (i = n.isJQuery(t) || n.isElement(t) ? e(t).first() : []).length ? i : null }
                    t = e.fn.typeahead, i = { www: "tt-www", attrs: "tt-attrs", typeahead: "tt-typeahead" }, o = {
                        initialize: function(t, o) {
                            var u;
                            return o = n.isArray(o) ? o : [].slice.call(arguments, 1), u = r((t = t || {}).classNames), this.each(g);

                            function g() {
                                var r, g, m, y, v, _, b, w, S, x, T;
                                n.each(o, (function(e) { e.highlight = !!t.highlight })), r = e(this), g = e(u.html.wrapper), m = p(t.hint), y = p(t.menu), v = !1 !== t.hint && !m, _ = !1 !== t.menu && !y, v && (m = c(r, u)), _ && (y = e(u.html.menu).css(u.css.menu)), m && m.val(""), r = d(r, u), (v || _) && (g.css(u.css.wrapper), r.css(v ? u.css.input : u.css.inputWithNoHint), r.wrap(g).parent().prepend(v ? m : null).append(_ ? y : null)), T = _ ? h : l, b = new s({ el: r }), w = new a({ hint: m, input: r }, u), S = new T({ node: y, datasets: o }, u), x = new f({ input: w, menu: S, eventBus: b, minLength: t.minLength }, u), r.data(i.www, u), r.data(i.typeahead, x)
                            }
                        },
                        isEnabled: function() { var t; return u(this.first(), (function(e) { t = e.isEnabled() })), t },
                        enable: function() { return u(this, (function(t) { t.enable() })), this },
                        disable: function() { return u(this, (function(t) { t.disable() })), this },
                        isActive: function() { var t; return u(this.first(), (function(e) { t = e.isActive() })), t },
                        activate: function() { return u(this, (function(t) { t.activate() })), this },
                        deactivate: function() { return u(this, (function(t) { t.deactivate() })), this },
                        isOpen: function() { var t; return u(this.first(), (function(e) { t = e.isOpen() })), t },
                        open: function() { return u(this, (function(t) { t.open() })), this },
                        close: function() { return u(this, (function(t) { t.close() })), this },
                        select: function(t) {
                            var n = !1,
                                i = e(t);
                            return u(this.first(), (function(t) { n = t.select(i) })), n
                        },
                        autocomplete: function(t) {
                            var n = !1,
                                i = e(t);
                            return u(this.first(), (function(t) { n = t.autocomplete(i) })), n
                        },
                        moveCursor: function(t) { var e = !1; return u(this.first(), (function(n) { e = n.moveCursor(t) })), e },
                        val: function(t) { var e; return arguments.length ? (u(this, (function(e) { e.setVal(t) })), this) : (u(this.first(), (function(t) { e = t.getVal() })), e) },
                        destroy: function() {
                            return u(this, (function(t, e) {
                                ! function(t) {
                                    var e, r;
                                    e = t.data(i.www), r = t.parent().filter(e.selectors.wrapper), n.each(t.data(i.attrs), (function(e, i) { n.isUndefined(e) ? t.removeAttr(i) : t.attr(i, e) })), t.removeData(i.typeahead).removeData(i.www).removeData(i.attr).removeClass(e.classes.input), r.length && (t.detach().insertAfter(r), r.remove())
                                }(e), t.destroy()
                            })), this
                        }
                    }, e.fn.typeahead = function(t) { return o[t] ? o[t].apply(this, [].slice.call(arguments, 1)) : o.initialize.apply(this, arguments) }, e.fn.typeahead.noConflict = function() { return e.fn.typeahead = t, this }
                }();
                var e, n, r, s, o, u, a, c, l, h, f
            }.apply(e, r)) || (t.exports = s)
        }).call(this, n(9).setImmediate)
    },
    3: function(t, e) {
        var n;
        n = function() { return this }();
        try { n = n || new Function("return this")() } catch (t) { "object" == typeof window && (n = window) }
        t.exports = n
    },
    485: function(t, e, n) {
        "use strict";
        n.r(e);
        var i = n(189),
            r = n.n(i);
        n.d(e, "typeahead", (function() { return r.a }))
    },
    9: function(t, e, n) {
        (function(t) {
            var i = void 0 !== t && t || "undefined" != typeof self && self || window,
                r = Function.prototype.apply;

            function s(t, e) { this._id = t, this._clearFn = e }
            e.setTimeout = function() { return new s(r.call(setTimeout, i, arguments), clearTimeout) }, e.setInterval = function() { return new s(r.call(setInterval, i, arguments), clearInterval) }, e.clearTimeout = e.clearInterval = function(t) { t && t.close() }, s.prototype.unref = s.prototype.ref = function() {}, s.prototype.close = function() { this._clearFn.call(i, this._id) }, e.enroll = function(t, e) { clearTimeout(t._idleTimeoutId), t._idleTimeout = e }, e.unenroll = function(t) { clearTimeout(t._idleTimeoutId), t._idleTimeout = -1 }, e._unrefActive = e.active = function(t) {
                clearTimeout(t._idleTimeoutId);
                var e = t._idleTimeout;
                e >= 0 && (t._idleTimeoutId = setTimeout((function() { t._onTimeout && t._onTimeout() }), e))
            }, n(10), e.setImmediate = "undefined" != typeof self && self.setImmediate || void 0 !== t && t.setImmediate || this && this.setImmediate, e.clearImmediate = "undefined" != typeof self && self.clearImmediate || void 0 !== t && t.clearImmediate || this && this.clearImmediate
        }).call(this, n(3))
    }
}));