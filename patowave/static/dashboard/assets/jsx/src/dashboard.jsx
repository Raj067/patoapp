
class Overview extends React.Component{
    render() {
    return <h1>Hello Overview</h1>
}
}

class Sales extends React.Component{
    render() {
    return <h1>Hello sales</h1>
}
}

class Expenses extends React.Component{
    render() {
    return <h1>Hello Expenses</h1>
}
}

class Contacts extends React.Component{
    render() {
    return <h1>Hello Contacts</h1>
}
}

class Products extends React.Component{
    render() {
    return <h1>Hello Products</h1>
}
}

class Warehouse extends React.Component{
    render() {
    return <h1>Hello Warehouse</h1>
}
}

class Bank extends React.Component{
    render() {
    return <h1>Hello Bank</h1>
}
}

class Accounting extends React.Component{
    render() {
    return <h1>Hello Accounting</h1>
}
}

class Reports extends React.Component{
    render() {
    return <h1>Hello Reports</h1>
}
}

class Documents extends React.Component{
    render() {
    return <h1>Hello Documents</h1>
}
}


class Dashboard extends React.Component {
       constructor(props) {
    super(props);
    this.state = { active: 0 };
    }
    navBar() {
                return <nav className="layout-navbar container-xxl navbar navbar-expand-xl navbar-detached align-items-center bg-navbar-theme"
    id="layout-navbar">
    <div className="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0   d-xl-none ">
        <a className="nav-item nav-link px-0 me-xl-4" href="javascript:void(0)">
            <i className="bx bx-menu bx-sm"></i>
        </a>
    </div>
    <div className="navbar-nav-right d-flex align-items-center" id="navbar-collapse">
        <div className="navbar-nav align-items-center">
            <div className="nav-item navbar-search-wrapper mb-0">
                <a className="nav-item nav-link search-toggler px-0" href="javascript:void(0);">
                    <i className="bx bx-search bx-sm"></i>
                    <span className="d-none d-md-inline-block text-muted">Search (Ctrl+/)</span>
                </a>
            </div>
        </div>
        <ul className="navbar-nav flex-row align-items-center ms-auto">
            <li className="nav-item me-2 me-xl-0">
                <a className="nav-link style-switcher-toggle hide-arrow" href="javascript:void(0);" 
                    id="my-nav-theme">
                    <i className='bx bx-moon bx-sm'></i>
                </a>
            </li>
            <li className="nav-item dropdown-shortcuts navbar-dropdown dropdown me-2 me-xl-0">
                <a className="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown"
                    data-bs-auto-close="outside" aria-expanded="false">
                    <i className='bx bx-grid-alt bx-sm'></i>
                </a>
                <div className="dropdown-menu dropdown-menu-end py-0">
                    <div className="dropdown-menu-header border-bottom">
                        <div className="dropdown-header d-flex align-items-center py-3">
                            <h5 className="text-body mb-0 me-auto">Shortcuts</h5>
                            <a href="javascript:void(0)" className="dropdown-shortcuts-add text-body"
                                data-bs-toggle="tooltip" data-bs-placement="top" title="Add shortcuts"><i
                                    className="bx bx-sm bx-plus-circle"></i></a>
                        </div>
                    </div>
                    <div className="dropdown-shortcuts-list scrollable-container">
                        <div className="row row-bordered overflow-visible g-0">
                            <div className="dropdown-shortcuts-item col">
                                <span className="dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2">
                                    <i className="bx bx-calendar fs-4"></i>
                                </span>
                                <a href="/dashboard/gbv-reports/" className="stretched-link">GBV Reports</a>
                            </div>
                            <div className="dropdown-shortcuts-item col">
                                <span className="dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2">
                                    <i className="bx bx-food-menu fs-4"></i>
                                </span>
                                <a href="/dashboard/sms-page/" className="stretched-link">SMS</a>
                            </div>
                        </div>
                        <div className="row row-bordered overflow-visible g-0">
                            <div className="dropdown-shortcuts-item col">
                                <span className="dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2">
                                    <i className="bx bx-user fs-4"></i>
                                </span>
                                <a href="/dashboard/whatsapp-page/" className="stretched-link">WhatsApp</a>
                            </div>
                            <div className="dropdown-shortcuts-item col">
                                <span className="dropdown-shortcuts-icon bg-label-secondary rounded-circle mb-2">
                                    <i className="bx bx-check-shield fs-4"></i>
                                </span>
                                <a href="/dashboard/emails-page/" className="stretched-link">Email</a>
                            </div>
                        </div>
                    </div>
                </div>
            </li>
            <li className="nav-item dropdown-notifications navbar-dropdown dropdown me-3 me-xl-1">
                <a className="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown"
                    data-bs-auto-close="outside" aria-expanded="false">
                    <i className="bx bx-bell bx-sm"></i>
                </a>
                <ul className="dropdown-menu dropdown-menu-end py-0">
                    <li className="dropdown-menu-header border-bottom">
                        <div className="dropdown-header d-flex align-items-center py-3">
                            <h5 className="text-body mb-0 me-auto">Notification</h5>
                            <a href="javascript:void(0)" className="dropdown-notifications-all text-body"
                                data-bs-toggle="tooltip" data-bs-placement="top" title="Mark all as read"><i
                                    className="bx fs-4 bx-envelope-open"></i></a>
                        </div>
                    </li>
                    <li className="dropdown-notifications-list scrollable-container">
                        <ul className="list-group list-group-flush" id="my-post">
                        </ul>
                    </li>
                    <li className="dropdown-menu-footer border-top">
                        <a href="/dashboard/message/" className="dropdown-item d-flex justify-content-center p-3">
                            View all notifications
                        </a>
                    </li>
                </ul>
            </li>
            <li className="nav-item navbar-dropdown dropdown-user dropdown">
                <a className="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div className="avatar avatar-online">
                        <img  src=".." alt="..." className="w-px-40 h-auto rounded-circle"
                            style={{height: "35px", width: "35px"}} />
                    </div>
                </a>
                <ul className="dropdown-menu dropdown-menu-end">
                    <li>
                        <a className="dropdown-item" href="/dashboard/account/">
                            <div className="d-flex">
                                <div className="flex-shrink-0 me-3">
                                    <div className="avatar avatar-online">
                                        <img src="..." alt="..." className="rounded-circle"
                                            style={{height: "40px", width: "40px"}} />
                                    </div>
                                </div>
                                <div className="flex-grow-1">
                                    <span className="fw-semibold d-block">Hello</span>
                                    <small className="text-muted">Admin</small>
                                </div>
                            </div>
                        </a>
                    </li>
                    <li>
                        <div className="dropdown-divider"></div>
                    </li>
                    <li>
                        <a className="dropdown-item" href="/dashboard/profile/">
                            <i className="bx bx-user me-2"></i>
                            <span className="align-middle">My Profile</span>
                        </a>
                    </li>
                    <li>
                        <a className="dropdown-item" href="/dashboard/account/">
                            <i className="bx bx-cog me-2"></i>
                            <span className="align-middle">Settings</span>
                        </a>
                    </li>
                    <li>
                        <div className="dropdown-divider"></div>
                    </li>
                    <li>
                        <a className="dropdown-item" href="/accounts/logout/">
                            <i className="bx bx-power-off me-2"></i>
                            <span className="align-middle">Log Out</span>
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
            </div>
    <div className="navbar-search-wrapper search-input-wrapper d-none">
        <span className="twitter-typeahead" style={{position: "relative", display: "inline-block"}}><input type="text"
                className="form-control search-input container-xxl border-0 tt-input" placeholder="Search..."
                aria-label="Search..." autoComplete="off" spellCheck="false" dir="auto"
                style={{position: "relative", verticalAlign: "top"}} />
            <pre aria-hidden="true"
                style={{position: "absolute", visibility: "hidden", whiteSpace: "pre", fontFamily: "Public Sans, -apple-system, BlinkMacSystemFont, Segoe UI, Oxygen, Ubuntu, Cantarell, Fira Sans, Droid Sans, Helvetica Neue, sans-serif", fontSize: "15px", fontStyle: "normal", fontVariant: "normal", fontWeight: "400", wordSpacing: "0px", letterSpacing: "0px", textIndent: "0px", textRendering: "auto", textTransform: "none"}}></pre>
            <div className="tt-menu navbar-search-suggestion ps"
                style={{position: "absolute", top: "100%", left: "0px", zIndex: "100", display: "none"}}>
                <div className="tt-dataset tt-dataset-pages"></div>
                <div className="tt-dataset tt-dataset-files"></div>
                        <div className="tt-dataset tt-dataset-members"></div>
                        
                <div className="ps__rail-x" style={{left: "0px", bottom: "0px"}}>
                    <div className="ps__thumb-x" tabIndex="0" style={{left: "0px", width: "0px"}}></div>
                </div> 
                <div className="ps__rail-y" style={{top: "0px", right: "0px"}}>
                    <div className="ps__thumb-y" tabIndex="0" style={{top: "0px", height: "0px"}}></div>
                </div>
            </div>
        </span>
        <i className="bx bx-x bx-sm search-toggler cursor-pointer"></i>
    </div>
</nav>
    }
     menu() {
        return <aside id="layout-menu" className="layout-menu menu-vertical menu bg-menu-theme">

    <div className="app-brand demo ">
        <a href="/dashboard/" className="app-brand-link">
            <span className="app-brand-logo demo">
                <img src="/static/images/icon.png" alt="PatoWave" srcSet="" width="25px" height="25px" />
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
        <li className={this.state.active == 0?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/overview" className="menu-link" onClick={()=>{this.setState({active:0})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Dashboards">Overview</div>
            </a>
        </li>
        <li className={this.state.active == 1?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/sales" className="menu-link"  onClick={()=>{this.setState({active:1})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Sales</div>
            </a>
        </li>
        <li className={this.state.active == 2?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/expenses" className="menu-link"  onClick={()=>{this.setState({active:2})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Expenses</div>
            </a>
        </li>
        <li className={this.state.active == 3?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/contacts" className="menu-link" onClick={()=>{this.setState({active:3})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Contacts</div>
            </a>
        </li>
        <li className={this.state.active == 4?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/products" className="menu-link" onClick={()=>{this.setState({active:4})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Products</div>
            </a>
        </li>
        <li className={this.state.active == 5?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/warehouse" className="menu-link" onClick={()=>{this.setState({active:5})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Warehouse</div>
            </a>
        </li>
        <li className={this.state.active == 6?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/cash&bank" className="menu-link" onClick={()=>{this.setState({active:6})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Cash & Bank</div>
            </a>
        </li>
        <li className={this.state.active == 7?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/accounting" className="menu-link"  onClick={()=>{this.setState({active:7})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Accounting</div>
            </a>
        </li>
        <li className={this.state.active == 8?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/reports" className="menu-link"  onClick={()=>{this.setState({active:8})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Reports</div>
            </a>
        </li>
        <li className={this.state.active == 9?"menu-item active":"menu-item"}>
            <a href="/dashboard/#/documents" className="menu-link"  onClick={()=>{this.setState({active:9})}}>
                <i className="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Documents</div>
            </a>
        </li>
    </ul>
</aside>
    }
    render() {
        return     <div className="layout-wrapper layout-content-navbar  ">
        <div className="layout-container">
            {this.menu()}

            <div className="layout-page">
                {this.navBar()}
                <div className="content-wrapper">
                    
                    <div className="content-backdrop fade"></div>
                </div>
            </div>
        </div>

        <div className="layout-overlay layout-menu-toggle"></div>

        <div className="drag-target"></div>

    </div>
    }
}
var rootPro = document.getElementById('root')
const projectRoot = ReactDOM.createRoot(rootPro);

var rootDiv = document.getElementById('root')
const root = ReactDOM.createRoot(rootDiv);
root.render(<Dashboard />);