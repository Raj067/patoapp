function Hello() {
    return React.createElement(
        "aside",
        { id: "layout-menu", "class": "layout-menu menu-vertical menu bg-menu-theme" },
        React.createElement(
            "div",
            { "class": "app-brand demo " },
            React.createElement(
                "a",
                { href: "/dashboard/", "class": "app-brand-link" },
                React.createElement(
                    "span",
                    { "class": "app-brand-logo demo" },
                    React.createElement("img", { src: "/static/images/icon.png", alt: "PatoWave", srcset: "", width: "25px", height: "25px" })
                ),
                React.createElement(
                    "span",
                    { "class": "app-brand-text demo menu-text fw-bolder ms-2",
                        style: "color: #33796f!important;text-transform: none!important;" },
                    "PatoWave"
                )
            ),
            React.createElement(
                "a",
                { href: "javascript:void(0);", "class": "layout-menu-toggle menu-link text-large ms-auto" },
                React.createElement("i", { "class": "bx bx-chevron-left bx-sm align-middle" })
            )
        ),
        React.createElement("div", { "class": "menu-inner-shadow" }),
        React.createElement(
            "ul",
            { "class": "menu-inner py-1", id: "my-nav-aside" },
            React.createElement(
                "li",
                { "class": "menu-item", id: "overview-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/overview", "class": "menu-link", onclick: "overviewFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Dashboards" },
                        "Overview"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "sales-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/sales", "class": "menu-link", onclick: "salesFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Sales"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "expenses-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/expenses", "class": "menu-link", onclick: "expensesFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Expenses"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "contacts-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/contacts", "class": "menu-link", onclick: "contactsFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Contacts"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "products-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/products", "class": "menu-link", onclick: "productsFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Products"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "warehouse-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/warehouse", "class": "menu-link", onclick: "warehouseFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Warehouse"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "bank-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/cash&bank", "class": "menu-link", onclick: "bankFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Cash & Bank"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "accounting-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/accounting", "class": "menu-link", onclick: "accountingFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Accounting"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "reports-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/reports", "class": "menu-link", onclick: "reportsFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
                    React.createElement(
                        "div",
                        { "data-i18n": "Sales" },
                        "Reports"
                    )
                )
            ),
            React.createElement(
                "li",
                { "class": "menu-item", id: "documents-page" },
                React.createElement(
                    "a",
                    { href: "/dashboard/#/documents", "class": "menu-link", onclick: "documentsFunc()" },
                    React.createElement("i", { "class": "menu-icon tf-icons bx bx-home-circle" }),
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