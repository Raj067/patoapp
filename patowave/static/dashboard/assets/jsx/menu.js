'use strict';

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var domContainer = document.getElementById('root');
var root = ReactDOM.createRoot(domContainer);
root.render(React.createElement(Overview));

var NavigationMenu = function (_React$Component) {
    _inherits(NavigationMenu, _React$Component);

    function NavigationMenu(props) {
        _classCallCheck(this, NavigationMenu);

        var _this = _possibleConstructorReturn(this, (NavigationMenu.__proto__ || Object.getPrototypeOf(NavigationMenu)).call(this, props));

        _this.state = { selected: 1 };
        return _this;
    }

    _createClass(NavigationMenu, [{
        key: 'render',
        value: function render() {
            var _this2 = this;

            if (this.state.liked) {
                return 'You liked this.';
            }
            return React.createElement(
                'div',
                { id: 'layout-menu', className: 'layout-menu menu-vertical menu bg-menu-theme' },
                React.createElement(
                    'div',
                    { className: 'app-brand demo ' },
                    React.createElement(
                        'a',
                        { href: '/dashboard/', className: 'app-brand-link' },
                        React.createElement('span', { className: 'app-brand-logo demo' }),
                        React.createElement(
                            'span',
                            { className: 'app-brand-text demo menu-text fw-bolder ms-2',
                                style: { color: "#33796f", textTransform: "none" } },
                            'PatoWave'
                        )
                    ),
                    React.createElement(
                        'a',
                        { href: 'javascript:void(0);', className: 'layout-menu-toggle menu-link text-large ms-auto' },
                        React.createElement('i', { className: 'bx bx-chevron-left bx-sm align-middle' })
                    )
                ),
                React.createElement('div', { className: 'menu-inner-shadow' }),
                React.createElement(
                    'ul',
                    { className: 'menu-inner py-1', id: 'my-nav-aside' },
                    React.createElement(
                        'li',
                        { className: this.state.selected == 1 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#overview/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Overview));
                                    _this2.setState({ selected: 1 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-home-circle' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Overview' },
                                'Overview'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 2 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#sales/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Sales));
                                    _this2.setState({ selected: 2 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-group' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Sales' },
                                'Sales'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 3 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#expenses/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Expenses));
                                    _this2.setState({ selected: 3 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bxs-user-account' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Expenses' },
                                'Expenses'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 4 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#contacts/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Contacts));
                                    _this2.setState({ selected: 4 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Contacts' },
                                'Contacts'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 5 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#products/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Products));
                                    _this2.setState({ selected: 5 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Products' },
                                'Products'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 6 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#warehouse/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Warehouse));
                                    _this2.setState({ selected: 6 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Warehouse' },
                                'Warehouse'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 7 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#cash&bank/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Bank));
                                    _this2.setState({ selected: 7 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Cash & Bank' },
                                'Cash & Bank'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 8 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#accounting/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Accounting));
                                    _this2.setState({ selected: 8 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Accounting' },
                                'Accounting'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 9 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#reports/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Reports));
                                    _this2.setState({ selected: 9 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Reports' },
                                'Reports'
                            )
                        )
                    ),
                    React.createElement(
                        'li',
                        { className: this.state.selected == 10 ? "menu-item active" : "menu-item" },
                        React.createElement(
                            'a',
                            { href: '/dashboard/#documents/', className: 'menu-link', onClick: function onClick() {
                                    root.render(React.createElement(Documents));
                                    _this2.setState({ selected: 10 });
                                } },
                            React.createElement('i', { className: 'menu-icon tf-icons bx bx-calendar' }),
                            React.createElement(
                                'div',
                                { 'data-i18n': 'Documents' },
                                'Documents'
                            )
                        )
                    )
                )
            );
        }
    }]);

    return NavigationMenu;
}(React.Component);

var nav = document.getElementById('nav-menu-main');
var root1 = ReactDOM.createRoot(nav);
root1.render(React.createElement(NavigationMenu));