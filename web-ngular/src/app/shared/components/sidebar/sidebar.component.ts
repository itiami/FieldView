import { Component, EventEmitter, Output } from '@angular/core';


type MenuItem = {
  icon: string;
  label: string;
  link: string;
  exact?: boolean;
  badge?: string | number;
};


@Component({
  selector: 'fw-sidebar',
  standalone: false,
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.scss'
})
export class SidebarComponent {
  @Output() navigate = new EventEmitter<void>();

  menuTop: MenuItem[] = [
    { icon: 'group',       label: 'Users',     link: '/users',     exact: true },
    { icon: 'description', label: 'Documents', link: '/documents', exact: true },
    { icon: 'schedule',    label: 'Realtime',  link: '/realtime',  exact: true },
    { icon: 'insights',    label: 'Reports',   link: '/reports',   exact: true },
  ];

  quickActions: MenuItem[] = [
    { icon: 'login',  label: 'Clock In',  link: '/realtime' },
    { icon: 'logout', label: 'Clock Out', link: '/realtime' },
  ];

  onNavigate() {
    this.navigate.emit();
  }
}
