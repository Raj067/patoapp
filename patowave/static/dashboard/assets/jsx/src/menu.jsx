'use strict';


const domContainer = document.getElementById('root');
const root = ReactDOM.createRoot(domContainer);
root.render(React.createElement(Overview));

class NavigationMenu extends React.Component {
  constructor(props) {
    super(props);
    this.state = { selected: 1 };
  }

  render() {
    if (this.state.liked) {
      return 'You liked this.';
    }
    return <div id="layout-menu" className="layout-menu menu-vertical menu bg-menu-theme">

    <div className="app-brand demo ">
        <a href="/dashboard/" className="app-brand-link">

            <span className="app-brand-logo demo">
            </span>
            <span className="app-brand-text demo menu-text fw-bolder ms-2"
                style={{color: "#33796f", textTransform: "none"}}>PatoWave</span>
        </a>

        <a href="javascript:void(0);" className="layout-menu-toggle menu-link text-large ms-auto">
            <i className="bx bx-chevron-left bx-sm align-middle"></i>
        </a>
    </div>

    <div className="menu-inner-shadow"></div>

    <ul className="menu-inner py-1" id="my-nav-aside">
        <li className={this.state.selected == 1?"menu-item active":"menu-item"}>
            <a href="/dashboard/#overview/" className="menu-link" onClick ={() => {
                root.render(React.createElement(Overview));
                    this.setState({ selected: 1 });
                }} >
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Overview">Overview</div>
            </a>
        </li>

        <li className={this.state.selected == 2?"menu-item active":"menu-item"}>
                <a href="/dashboard/#sales/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Sales));
                    this.setState({ selected: 2 })
                }}>
                <i className='menu-icon tf-icons bx bx-group'></i>
                <div data-i18n="Sales">Sales</div>
            </a>
        </li>
        <li className={this.state.selected == 3?"menu-item active":"menu-item"}>
                <a href="/dashboard/#expenses/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Expenses));
                    this.setState({ selected: 3 })
                }}>
                <i className='menu-icon tf-icons bx bxs-user-account'></i>
                <div data-i18n="Expenses">Expenses</div>
            </a>
        </li>
        <li className={this.state.selected == 4?"menu-item active":"menu-item"}>
                <a href="/dashboard/#contacts/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Contacts));
                this.setState({ selected: 4 })}}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Contacts">Contacts</div>
            </a>
        </li>
        <li className={this.state.selected == 5?"menu-item active":"menu-item"}>
            <a href="/dashboard/#products/" className="menu-link"  onClick ={() => {
                root.render(React.createElement(Products));
                this.setState({ selected: 5 })}}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Products">Products</div>
            </a>
        </li>
        <li className={this.state.selected == 6?"menu-item active":"menu-item"}>
                <a href="/dashboard/#warehouse/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Warehouse));
                    this.setState({ selected: 6 })
                }}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Warehouse">Warehouse</div>
            </a>
        </li>
        <li className={this.state.selected == 7?"menu-item active":"menu-item"}>
                <a href="/dashboard/#cash&bank/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Bank));
                    this.setState({ selected: 7 })
                }}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Cash & Bank">Cash & Bank</div>
            </a>
        </li>
        <li className={this.state.selected == 8?"menu-item active":"menu-item"}>
                <a href="/dashboard/#accounting/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Accounting));
                    this.setState({ selected: 8 })
                }}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Accounting">Accounting</div>
            </a>
        </li>
        <li className={this.state.selected == 9?"menu-item active":"menu-item"}>
                <a href="/dashboard/#reports/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Reports));
                    this.setState({ selected: 9 })
                }}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Reports">Reports</div>
            </a>
        </li>
        <li className={this.state.selected == 10?"menu-item active":"menu-item"}>
                <a href="/dashboard/#documents/" className="menu-link" onClick={() => {
                    root.render(React.createElement(Documents));
                    this.setState({ selected: 10 })
                }}>
                <i className="menu-icon tf-icons bx bx-calendar"></i>
                <div data-i18n="Documents">Documents</div>
            </a>
        </li>
    </ul>
</div>
  }
}

const nav = document.getElementById('nav-menu-main');
const root1 = ReactDOM.createRoot(nav);
root1.render(React.createElement(NavigationMenu));
