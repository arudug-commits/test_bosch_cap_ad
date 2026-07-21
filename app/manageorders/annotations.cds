using CatalogService as service from '../../srv/CatalogService';

annotate service.PurchaseOrderSet with @(

    UI.SelectionFields      : [
        PO_ID,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY,
        GROSS_AMOUNT,
        CURRENCY_code,
        OVERALL_STATUS
    ],

    UI.LineItem             : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        //Label: 'Purchase Order ID'
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.COMPANY_NAME
        // Label: 'Company Name'
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY
        //Label: 'Country'
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        //Label: 'Gross Amount'
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action: 'CatalogService.boost',
            Inline: true,
            Label : 'boost',
        },

        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        //Label: 'Currency'
        },
        {
            $Type      : 'UI.DataField',
            Value      : OVERALL_STATUS,
            Criticality: Spiderman
        //Label: 'Overall Status'
        }
    ],

    UI.HeaderInfo           : {
        TypeName      : 'Purchase Order',
        TypeNamePlural: 'Purchase Orders',
        Title         : {Value: PO_ID},
        Description   : {Value: OVERALL.description},
        ImageUrl      : 'https://1000logos.net/wp-content/uploads/2016/10/Bosch-Logo.png',
    },


    //Used for creating blocks in the object page
    UI.Facets               : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'General Information',
            Facets: [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Basic Data',
                    Target: '@UI.Identification'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Pricing Data',
                    Target: '@UI.FieldGroup#spiderman'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Delivery Data',
                    Target: '@UI.FieldGroup#batman'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target: 'Items/@UI.LineItem',
            Label : 'Items'
        },

    ],

    UI.Identification       : [
        {
            $Type: 'UI.DataField',
            Value: PO_ID
        },
        {
            $Type: 'UI.DataField',
            Value: PARTNER_GUID_NODE_KEY
        },
        {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS
        }
    ],

    UI.FieldGroup #spiderman: {Data: [
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT
        }
    ]},

    UI.FieldGroup #batman   : {Data: [
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code
        },
        {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS
        }
    ]}
);


annotate service.PurchaseItemSet with @(
    UI.HeaderInfo    : {
        TypeName      : 'Purchase Order Item',
        TypeNamePlural: 'Purchase Order Items',
        Title         : {Value: PO_ITEM_POS},
        Description   : {Value: PRODUCT_GUID.DESCRIPTION},
    },
    UI.Facets        : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.Identification',
        Label : 'Item Data'
    }, ],
    UI.Identification: [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID_NODE_KEY,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
    ],


    UI.LineItem      : [
        {
            $Type: 'UI.DataField',
            Value: PO_ITEM_POS,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.CATEGORY,
        },
        {
            $Type: 'UI.DataField',
            Value: PRODUCT_GUID.DESCRIPTION,
        },
        {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
        },
        {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
        },
    ],


);

annotate service.PurchaseOrderSet with {
    @Common.Text: OVERALL.description
    OVERALL
};

annotate service.PurchaseOrderSet with {
    @Common.Text                    : OVERALL.description
    @Common.ValueList               : {
        $Type         : 'Common.ValueListType/FixedValues',
        CollectionPath: 'StatusCodeSet',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: OVERALL_STATUS,
                ValueListProperty: 'STATUS'
            },
            {
                $Type            : 'Common.ValueListParameterOut',
                LocalDataProperty: OVERALL_STATUS,
                ValueListProperty: 'description'
            }
        ],
        Label         : 'Overall Status'
    }
    @Common.ValueListWithFixedValues: true
    OVERALL;

    @Common.Text                    : PARTNER_GUID.COMPANY_NAME
    @Valuelist.entity               : service.SupplierSet
    PARTNER_GUID;

};

annotate service.PurchaseItemSet with {
    @Common.Text     : PRODUCT_GUID.DESCRIPTION
    @Valuelist.entity: service.ProductSet
    PRODUCT_GUID;
};


@cds.odata.valuelist
annotate service.SupplierSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: COMPANY_NAME
}], );

@cds.odata.valuelist
annotate service.ProductSet with @(UI.Identification: [{
    $Type: 'UI.DataField',
    Value: DESCRIPTION,
}], );
