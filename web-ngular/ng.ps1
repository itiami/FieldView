ng g m features/users --routing   
ng g m features/documents --routing
ng g m features/realtime --routing
ng g m features/reports --routing
ng g m shared
ng g c features/users/components/user-list --module=features/users/users.module
ng g c features/users/components/user-detail --module=features/users/users.module
ng g c features/documents/components/document-list --module=features/documents/documents.module
ng g c features/documents/components/document-detail --module=features/documents/documents.module
ng g c features/realtime/components/realtime-dashboard --module=features/realtime/realtime.module
ng g c features/reports/components/report-list --module=features/reports/reports.module
ng g c features/reports/components/report-detail --module=features/reports/reports.module
ng g c shared/components/sidebar --module=shared/shared.module
ng g c shared/components/footer --module=shared/shared.module   

# Generate Admin Component
ng g module features/admin --route admin --module app.module; ng g component features/admin --module=features/admin/admin.module


