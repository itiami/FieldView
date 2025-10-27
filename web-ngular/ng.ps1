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



ng g m module core
cd core
mkdir layout, services, guards, interceptors, components, models
# This creates layout.component.ts/html/scss inside core/layout
ng g component core/layout --flat=false
ng g component core/components/not-found --flat=false
ng g component core/components/loading-spinner --flat=false

ng g service core/services/api
ng g service core/services/auth
ng g service core/services/logger
ng g service core/services/notification
ng g service core/services/socket
ng g service core/services/time


ng g guard core/guards/auth
ng g guard core/guards/role
ng g guard core/guards/unsaved-changes


ng g interceptor core/interceptors/auth
ng g interceptor core/interceptors/error
ng g interceptor core/interceptors/loader
