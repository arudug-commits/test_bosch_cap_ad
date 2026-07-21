using {anunbhav.cds as cdsser} from '../db/CDSView';

service CDSService @(path: '/cds') {

    entity POWorklist  as projection on cdsser.CDSView.POWorklist;

    entity ProductView as projection on cdsser.CDSView.ProductView {
            *,
            virtual POCount : Integer
        };

    entity ItemView as projection on cdsser.CDSView.ItemView;

}
