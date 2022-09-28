var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var Overview = function (_React$Component) {
    _inherits(Overview, _React$Component);

    function Overview() {
        _classCallCheck(this, Overview);

        return _possibleConstructorReturn(this, (Overview.__proto__ || Object.getPrototypeOf(Overview)).apply(this, arguments));
    }

    _createClass(Overview, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Overview"
            );
        }
    }]);

    return Overview;
}(React.Component);

var Sales = function (_React$Component2) {
    _inherits(Sales, _React$Component2);

    function Sales() {
        _classCallCheck(this, Sales);

        return _possibleConstructorReturn(this, (Sales.__proto__ || Object.getPrototypeOf(Sales)).apply(this, arguments));
    }

    _createClass(Sales, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello sales"
            );
        }
    }]);

    return Sales;
}(React.Component);

var Expenses = function (_React$Component3) {
    _inherits(Expenses, _React$Component3);

    function Expenses() {
        _classCallCheck(this, Expenses);

        return _possibleConstructorReturn(this, (Expenses.__proto__ || Object.getPrototypeOf(Expenses)).apply(this, arguments));
    }

    _createClass(Expenses, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Expenses"
            );
        }
    }]);

    return Expenses;
}(React.Component);

var Contacts = function (_React$Component4) {
    _inherits(Contacts, _React$Component4);

    function Contacts() {
        _classCallCheck(this, Contacts);

        return _possibleConstructorReturn(this, (Contacts.__proto__ || Object.getPrototypeOf(Contacts)).apply(this, arguments));
    }

    _createClass(Contacts, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Contacts"
            );
        }
    }]);

    return Contacts;
}(React.Component);

var Products = function (_React$Component5) {
    _inherits(Products, _React$Component5);

    function Products() {
        _classCallCheck(this, Products);

        return _possibleConstructorReturn(this, (Products.__proto__ || Object.getPrototypeOf(Products)).apply(this, arguments));
    }

    _createClass(Products, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Products"
            );
        }
    }]);

    return Products;
}(React.Component);

var Warehouse = function (_React$Component6) {
    _inherits(Warehouse, _React$Component6);

    function Warehouse() {
        _classCallCheck(this, Warehouse);

        return _possibleConstructorReturn(this, (Warehouse.__proto__ || Object.getPrototypeOf(Warehouse)).apply(this, arguments));
    }

    _createClass(Warehouse, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Warehouse"
            );
        }
    }]);

    return Warehouse;
}(React.Component);

var Bank = function (_React$Component7) {
    _inherits(Bank, _React$Component7);

    function Bank() {
        _classCallCheck(this, Bank);

        return _possibleConstructorReturn(this, (Bank.__proto__ || Object.getPrototypeOf(Bank)).apply(this, arguments));
    }

    _createClass(Bank, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Bank"
            );
        }
    }]);

    return Bank;
}(React.Component);

var Accounting = function (_React$Component8) {
    _inherits(Accounting, _React$Component8);

    function Accounting() {
        _classCallCheck(this, Accounting);

        return _possibleConstructorReturn(this, (Accounting.__proto__ || Object.getPrototypeOf(Accounting)).apply(this, arguments));
    }

    _createClass(Accounting, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Accounting"
            );
        }
    }]);

    return Accounting;
}(React.Component);

var Reports = function (_React$Component9) {
    _inherits(Reports, _React$Component9);

    function Reports() {
        _classCallCheck(this, Reports);

        return _possibleConstructorReturn(this, (Reports.__proto__ || Object.getPrototypeOf(Reports)).apply(this, arguments));
    }

    _createClass(Reports, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Reports"
            );
        }
    }]);

    return Reports;
}(React.Component);

var Documents = function (_React$Component10) {
    _inherits(Documents, _React$Component10);

    function Documents() {
        _classCallCheck(this, Documents);

        return _possibleConstructorReturn(this, (Documents.__proto__ || Object.getPrototypeOf(Documents)).apply(this, arguments));
    }

    _createClass(Documents, [{
        key: "render",
        value: function render() {
            return React.createElement(
                "h1",
                null,
                "Hello Documents"
            );
        }
    }]);

    return Documents;
}(React.Component);

var Dashboard = function (_React$Component11) {
    _inherits(Dashboard, _React$Component11);

    function Dashboard(props) {
        _classCallCheck(this, Dashboard);

        var _this11 = _possibleConstructorReturn(this, (Dashboard.__proto__ || Object.getPrototypeOf(Dashboard)).call(this, props));

        _this11.state = { active: 0 };
        return _this11;
    }

    _createClass(Dashboard, [{
        key: "navBar",
        value: function navBar() {
            return React.createElement(
                "nav",
                { className: "layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme",
                    id: "layout-navbar" },
                React.createElement(
                    "div",
                    { className: "layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0   d-xl-none " },
                    React.createElement(
                        "a",
                        { className: "nav-item nav-link px-0 me-xl-4", href: "javascript:void(0)" },
                        React.createElement("i", { className: "bx bx-menu bx-sm" })
                    )
                ),
                React.createElement(
                    "div",
                    { className: "navbar-nav-right d-flex align-items-center", id: "navbar-collapse" },
                    React.createElement(
                        "div",
                        { className: "navbar-nav align-items-center" },
                        React.createElement(
                            "div",
                            { className: "nav-item navbar-search-wrapper mb-0" },
                            React.createElement(
                                "a",
                                { className: "nav-item nav-link search-toggler px-0", href: "javascript:void(0);" },
                                React.createElement("i", { className: "bx bx-search bx-sm" }),
                                React.createElement(
                                    "span",
                                    { className: "d-none d-md-inline-block text-muted" },
                                    "Search (Ctrl+/)"
                                )
                            )
                        )
                    ),
                    React.createElement(
                        "ul",
                        { className: "navbar-nav flex-row align-items-center ms-auto" },
                        React.createElement(
                            "li",
                            { className: "nav-item me-2 me-xl-0" },
                            React.createElement(
                                "a",
                                { className: "nav-link style-switcher-toggle hide-arrow", href: "javascript:void(0);",
                                    id: "my-nav-theme" },
                                React.createElement("i", { className: "bx bx-moon bx-sm" })
                            )
                        ),
                        React.createElement(
                            "li",
                            { className: "nav-item dropdown-shortcuts navbar-dropdown dropdown me-2 me-xl-0" },
                            React.createElement(
                                "a",
                                { className: "nav-link dropdown-toggle hide-arrow", href: "javascript:void(0);", "data-bs-toggle": "dropdown",
                                    "data-bs-auto-close": "outside", "aria-expanded": "false" },
                                React.createElement("i", { className: "bx bx-grid-alt bx-sm" })
                            ),
                            React.createElement(
                                "div",
                                { className: "dropdown-menu dropdown-menu-end py-0" },
                                React.createElement(
                                    "div",
                                    { className: "dropdown-menu-header border-bottom" },
                                    React.createElement(
                                        "div",
                                        { className: "dropdown-header d-flex align-items-center py-3" },
                                        React.createElement(
                                            "h5",
                                            { className: "text-body mb-0 me-auto" },
                                            "Shortcuts"
                                        ),
                                        React.createElement(
                                            "a",
                                            { href: "javascript:void(0)", className: "dropdown-shortcuts-add text-body",
                                                "data-bs-toggle": "tooltip", "data-bs-placement": "top", title: "Add shortcuts" },
                                            React.createElement("i", {
                                                className: "bx bx-sm bx-plus-circle" })
                                        )
                                    )
                                ),
                                React.createElement(
                                    "div",
                                    { className: "dropdown-shortcuts-list scrollable-container" },
                                    React.createElement(
                                        "div",
                                        { className: "row row-bordered overflow-visible g-0" },
                                        React.createElement(
                                            "div",
                                            { className: "dropdown-shortcuts-item col" },
                                            React.createElement(
                                                "span",
                                                { className: "dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2" },
                                                React.createElement("i", { className: "bx bx-calendar fs-4" })
                                            ),
                                            React.createElement(
                                                "a",
                                                { href: "/dashboard/gbv-reports/", className: "stretched-link" },
                                                "GBV Reports"
                                            )
                                        ),
                                        React.createElement(
                                            "div",
                                            { className: "dropdown-shortcuts-item col" },
                                            React.createElement(
                                                "span",
                                                { className: "dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2" },
                                                React.createElement("i", { className: "bx bx-food-menu fs-4" })
                                            ),
                                            React.createElement(
                                                "a",
                                                { href: "/dashboard/sms-page/", className: "stretched-link" },
                                                "SMS"
                                            )
                                        )
                                    ),
                                    React.createElement(
                                        "div",
                                        { className: "row row-bordered overflow-visible g-0" },
                                        React.createElement(
                                            "div",
                                            { className: "dropdown-shortcuts-item col" },
                                            React.createElement(
                                                "span",
                                                { className: "dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2" },
                                                React.createElement("i", { className: "bx bx-user fs-4" })
                                            ),
                                            React.createElement(
                                                "a",
                                                { href: "/dashboard/whatsapp-page/", className: "stretched-link" },
                                                "WhatsApp"
                                            )
                                        ),
                                        React.createElement(
                                            "div",
                                            { className: "dropdown-shortcuts-item col" },
                                            React.createElement(
                                                "span",
                                                { className: "dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2" },
                                                React.createElement("i", { className: "bx bx-check-shield fs-4" })
                                            ),
                                            React.createElement(
                                                "a",
                                                { href: "/dashboard/emails-page/", className: "stretched-link" },
                                                "Email"
                                            )
                                        )
                                    )
                                )
                            )
                        ),
                        React.createElement(
                            "li",
                            { className: "nav-item dropdown-notifications navbar-dropdown dropdown me-3 me-xl-1" },
                            React.createElement(
                                "a",
                                { className: "nav-link dropdown-toggle hide-arrow", href: "javascript:void(0);", "data-bs-toggle": "dropdown",
                                    "data-bs-auto-close": "outside", "aria-expanded": "false" },
                                React.createElement("i", { className: "bx bx-bell bx-sm" })
                            ),
                            React.createElement(
                                "ul",
                                { className: "dropdown-menu dropdown-menu-end py-0" },
                                React.createElement(
                                    "li",
                                    { className: "dropdown-menu-header border-bottom" },
                                    React.createElement(
                                        "div",
                                        { className: "dropdown-header d-flex align-items-center py-3" },
                                        React.createElement(
                                            "h5",
                                            { className: "text-body mb-0 me-auto" },
                                            "Notification"
                                        ),
                                        React.createElement(
                                            "a",
                                            { href: "javascript:void(0)", className: "dropdown-notifications-all text-body",
                                                "data-bs-toggle": "tooltip", "data-bs-placement": "top", title: "Mark all as read" },
                                            React.createElement("i", {
                                                className: "bx fs-4 bx-envelope-open" })
                                        )
                                    )
                                ),
                                React.createElement(
                                    "li",
                                    { className: "dropdown-notifications-list scrollable-container" },
                                    React.createElement("ul", { className: "list-group list-group-flush", id: "my-post" })
                                ),
                                React.createElement(
                                    "li",
                                    { className: "dropdown-menu-footer border-top" },
                                    React.createElement(
                                        "a",
                                        { href: "/dashboard/message/", className: "dropdown-item d-flex justify-content-center p-3" },
                                        "View all notifications"
                                    )
                                )
                            )
                        ),
                        React.createElement(
                            "li",
                            { className: "nav-item navbar-dropdown dropdown-user dropdown" },
                            React.createElement(
                                "a",
                                { className: "nav-link dropdown-toggle hide-arrow", href: "javascript:void(0);", "data-bs-toggle": "dropdown" },
                                React.createElement(
                                    "div",
                                    { className: "avatar avatar-online" },
                                    React.createElement("img", { src: "..", alt: "...", className: "w-px-40 h-auto rounded-circle",
                                        style: { height: "35px", width: "35px" } })
                                )
                            ),
                            React.createElement(
                                "ul",
                                { className: "dropdown-menu dropdown-menu-end" },
                                React.createElement(
                                    "li",
                                    null,
                                    React.createElement(
                                        "a",
                                        { className: "dropdown-item", href: "/dashboard/account/" },
                                        React.createElement(
                                            "div",
                                            { className: "d-flex" },
                                            React.createElement(
                                                "div",
                                                { className: "flex-shrink-0 me-3" },
                                                React.createElement(
                                                    "div",
                                                    { className: "avatar avatar-online" },
                                                    React.createElement("img", { src: "...", alt: "...", className: "rounded-circle",
                                                        style: { height: "40px", width: "40px" } })
                                                )
                                            ),
                                            React.createElement(
                                                "div",
                                                { className: "flex-grow-1" },
                                                React.createElement(
                                                    "span",
                                                    { className: "fw-semibold d-block" },
                                                    "Hello"
                                                ),
                                                React.createElement(
                                                    "small",
                                                    { className: "text-muted" },
                                                    "Admin"
                                                )
                                            )
                                        )
                                    )
                                ),
                                React.createElement(
                                    "li",
                                    null,
                                    React.createElement("div", { className: "dropdown-divider" })
                                ),
                                React.createElement(
                                    "li",
                                    null,
                                    React.createElement(
                                        "a",
                                        { className: "dropdown-item", href: "/dashboard/profile/" },
                                        React.createElement("i", { className: "bx bx-user me-2" }),
                                        React.createElement(
                                            "span",
                                            { className: "align-middle" },
                                            "My Profile"
                                        )
                                    )
                                ),
                                React.createElement(
                                    "li",
                                    null,
                                    React.createElement(
                                        "a",
                                        { className: "dropdown-item", href: "/dashboard/account/" },
                                        React.createElement("i", { className: "bx bx-cog me-2" }),
                                        React.createElement(
                                            "span",
                                            { className: "align-middle" },
                                            "Settings"
                                        )
                                    )
                                ),
                                React.createElement(
                                    "li",
                                    null,
                                    React.createElement("div", { className: "dropdown-divider" })
                                ),
                                React.createElement(
                                    "li",
                                    null,
                                    React.createElement(
                                        "a",
                                        { className: "dropdown-item", href: "/accounts/logout/" },
                                        React.createElement("i", { className: "bx bx-power-off me-2" }),
                                        React.createElement(
                                            "span",
                                            { className: "align-middle" },
                                            "Log Out"
                                        )
                                    )
                                )
                            )
                        )
                    )
                ),
                React.createElement(
                    "div",
                    { className: "navbar-search-wrapper search-input-wrapper d-none" },
                    React.createElement(
                        "span",
                        { className: "twitter-typeahead", style: { position: "relative", display: "inline-block" } },
                        React.createElement("input", { type: "text",
                            className: "form-control search-input container-xxl border-0 tt-input", placeholder: "Search...",
                            "aria-label": "Search...", autoComplete: "off", spellCheck: "false", dir: "auto",
                            style: { position: "relative", verticalAlign: "top" } }),
                        React.createElement("pre", { "aria-hidden": "true",
                            style: { position: "absolute", visibility: "hidden", whiteSpace: "pre", fontFamily: "Public Sans, -apple-system, BlinkMacSystemFont, Segoe UI, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif", fontSize: "15px", fontStyle: "normal", fontVariant: "normal", fontWeight: "400", wordSpacing: "0px", letterSpacing: "0px", textIndent: "0px", textRendering: "auto", textTransform: "none" } }),
                        React.createElement(
                            "div",
                            { className: "tt-menu navbar-search-suggestion ps",
                                style: { position: "absolute", top: "100%", left: "0px", zIndex: "100", display: "none" } },
                            React.createElement("div", { className: "tt-dataset tt-dataset-pages" }),
                            React.createElement("div", { className: "tt-dataset tt-dataset-files" }),
                            React.createElement("div", { className: "tt-dataset tt-dataset-members" }),
                            React.createElement(
                                "div",
                                { className: "ps__rail-x", style: { left: "0px", bottom: "0px" } },
                                React.createElement("div", { className: "ps__thumb-x", tabIndex: "0", style: { left: "0px", width: "0px" } })
                            ),
                            React.createElement(
                                "div",
                                { className: "ps__rail-y", style: { top: "0px", right: "0px" } },
                                React.createElement("div", { className: "ps__thumb-y", tabIndex: "0", style: { top: "0px", height: "0px" } })
                            )
                        )
                    ),
                    React.createElement("i", { className: "bx bx-x bx-sm search-toggler cursor-pointer" })
                )
            );
        }
    }, {
        key: "menu",
        value: function menu() {
            var _this12 = this;

            return React.createElement(
                "aside",
                { id: "layout-menu", className: "layout-menu menu-vertical menu bg-menu-theme" },
                React.createElement(
                    "div",
                    { className: "app-brand demo " },
                    React.createElement(
                        "a",
                        { href: "/dashboard/", className: "app-brand-link" },
                        React.createElement(
                            "span",
                            { className: "app-brand-logo demo" },
                            React.createElement("img", { src: "/static/images/icon.png", alt: "PatoWave", srcSet: "", width: "25px", height: "25px" })
                        ),
                        React.createElement(
                            "span",
                            { className: "app-brand-text demo menu-text fw-bolder ms-2",
                                style: { color: "#33796f", textTransform: "none" } },
                            "PatoWave"
                        )
                    ),
                    React.createElement(
                        "a",
                        { href: "javascript:void(0);", className: "layout-menu-toggle menu-link text-large ms-auto" },
                        React.createElement("i", { className: "bx bx-chevron-left bx-sm align-middle" })
                    )
                ),
                React.createElement("div", { className: "menu-inner-shadow" }),
                React.createElement(
                    "ul",
                    { className: "menu-inner py-1", id: "my-nav-aside" },
                    React.createElement(
                        "li",
                        { className: this.state.active == 0 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/overview", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 0 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Dashboards" },
                                "Overview"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 1 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/sales", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 1 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Sales"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 2 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/expenses", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 2 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Expenses"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 3 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/contacts", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 3 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Contacts"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 4 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/products", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 4 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Products"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 5 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/warehouse", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 5 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Warehouse"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 6 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/cash&bank", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 6 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Cash & Bank"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 7 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/accounting", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 7 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Accounting"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 8 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/reports", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 8 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Reports"
                            )
                        )
                    ),
                    React.createElement(
                        "li",
                        { className: this.state.active == 9 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            "a",
                            { href: "/dashboard/#/documents", className: "menu-link", onClick: function onClick() {
                                    _this12.setState({ active: 9 });
                                } },
                            React.createElement("i", { className: "menu-icon tf-icons bx bx-home-circle" }),
                            React.createElement(
                                "div",
                                { "data-i18n": "Sales" },
                                "Documents"
                            )
                        )
                    )
                )
            );
        }
    }, {
        key: "render",
        value: function render() {
            return React.createElement(
                "div",
                { className: "layout-wrapper layout-content-navbar  " },
                React.createElement(
                    "div",
                    { className: "layout-container" },
                    this.menu(),
                    React.createElement(
                        "div",
                        { className: "layout-page" },
                        this.navBar(),
                        React.createElement(
                            "div",
                            { className: "content-wrapper" },
                            React.createElement("div", { className: "content-backdrop fade" })
                        )
                    )
                ),
                React.createElement("div", { className: "layout-overlay layout-menu-toggle" }),
                React.createElement("div", { className: "drag-target" })
            );
        }
    }]);

    return Dashboard;
}(React.Component);

var rootPro = document.getElementById('root');
var projectRoot = ReactDOM.createRoot(rootPro);

var rootDiv = document.getElementById('root');
var root = ReactDOM.createRoot(rootDiv);
root.render(React.createElement(Dashboard, null));