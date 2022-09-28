function Hello(){
    return <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">

    <div class="app-brand demo ">
        <a href="/dashboard/" class="app-brand-link">
            <span class="app-brand-logo demo">
                <img src="/static/images/icon.png" alt="PatoWave" srcset="" width="25px" height="25px" />
            </span>
            <span class="app-brand-text demo menu-text fw-bolder ms-2"
                style="color: #33796f!important;text-transform: none!important;">PatoWave</span>
        </a>
        <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto">
            <i class="bx bx-chevron-left bx-sm align-middle"></i>
        </a>
    </div>

    <div class="menu-inner-shadow"></div>

    <ul class="menu-inner py-1" id="my-nav-aside">
        <li class="menu-item" id="overview-page">
            <a href="/dashboard/#/overview" class="menu-link" onclick="overviewFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Dashboards">Overview</div>
            </a>
        </li>
        <li class="menu-item" id="sales-page">
            <a href="/dashboard/#/sales" class="menu-link" onclick="salesFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Sales</div>
            </a>
        </li>
        <li class="menu-item" id="expenses-page">
            <a href="/dashboard/#/expenses" class="menu-link" onclick="expensesFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Expenses</div>
            </a>
        </li>
        <li class="menu-item" id="contacts-page">
            <a href="/dashboard/#/contacts" class="menu-link" onclick="contactsFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Contacts</div>
            </a>
        </li>
        <li class="menu-item" id="products-page">
            <a href="/dashboard/#/products" class="menu-link" onclick="productsFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Products</div>
            </a>
        </li>
        <li class="menu-item" id="warehouse-page">
            <a href="/dashboard/#/warehouse" class="menu-link" onclick="warehouseFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Warehouse</div>
            </a>
        </li>
        <li class="menu-item" id="bank-page">
            <a href="/dashboard/#/cash&bank" class="menu-link" onclick="bankFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Cash & Bank</div>
            </a>
        </li>
        <li class="menu-item" id="accounting-page">
            <a href="/dashboard/#/accounting" class="menu-link" onclick="accountingFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Accounting</div>
            </a>
        </li>
        <li class="menu-item" id="reports-page">
            <a href="/dashboard/#/reports" class="menu-link" onclick="reportsFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Reports</div>
            </a>
        </li>
        <li class="menu-item" id="documents-page">
            <a href="/dashboard/#/documents" class="menu-link" onclick="documentsFunc()">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Sales">Documents</div>
            </a>
        </li>
    </ul>
</aside>
}
