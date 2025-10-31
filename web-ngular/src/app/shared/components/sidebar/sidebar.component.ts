// sidebar.component.ts

import { Component, EventEmitter, Output, OnInit } from '@angular/core';
import { Router } from '@angular/router';
import { isEmpty } from 'rxjs';


type MenuItem = {
  icon: string;
  label: string;
  link: string;
  exact?: boolean;
  badge?: string | number;
  children?: ChildItem[];  // nested items
};

type ChildItem = {
  label: string;
  link: string;
  exact?: boolean;
};



@Component({
  selector: 'fw-sidebar',
  standalone: false,
  templateUrl: './sidebar.component.html',
  styleUrl: './sidebar.component.scss'
})



export class SidebarComponent  {
  
  menuTop: MenuItem[] = [
    { icon: 'group', label: 'Users', link: '/users', exact: true },
    { icon: 'description', label: 'Documents', link: '', exact: true },
    { icon: 'schedule', label: 'Realtime', link: '/realtime', exact: true },
    { icon: 'insights', label: 'Reports', link: '/reports', exact: true },
    {
      icon: 'extension',
      label: 'Extra',
      link: '/ex',
      children: [
        { label: 'ETL', link: '/ex/etl', exact: true },
        { label: 'TS Basic', link: '/ex/ts-basic', exact: true },
        { label: 'OOP', link: '/ex/oop', exact: true },
      ],
    },
  ];

  listItems: Array<{ id: number; name: string; age: number; city?: string }> =  [
    { id: 2345, name: "Alice Johnson", age: 28, city: "New York" },
    { id: 4345, name: "Bob Smith", age: 35, city: undefined },
    { id: 6345, name: "Carol Davis", age: 22, city: "" },
    { id: 1345, name: "David Wilson", age: 41, city: "Houston" }
  ];


  @Output() navigate = new EventEmitter<void>();
  expanded = new Set<string>();

  constructor(private router: Router) {
    this.listItems.forEach(obj => {
      console.log(obj.city ?? "Unknown");
    });
  }



  /** 👇 Re-add this — it's missing in your latest error context */
  quickActions: MenuItem[] = [
    { icon: 'login',  label: 'Clock In',  link: '/realtime' },
    { icon: 'logout', label: 'Clock Out', link: '/realtime' },
  ];

  hasChildren(item: MenuItem): boolean {
    return !!item.children?.length;
  }

  isSectionActive(item: MenuItem): boolean {
    if (!item.link) return false;
    const url = this.router.url;
    return url === item.link || url.startsWith(item.link + '/');
  }

  isLinkActive(link: string, exact = true): boolean {
    return this.router.isActive(link, {
      paths: exact ? 'exact' : 'subset',
      queryParams: 'ignored',
      fragment: 'ignored',
      matrixParams: 'ignored',
    });
  }

  toggleSection(key: string) {
    if (this.expanded.has(key)) this.expanded.delete(key);
    else this.expanded.add(key);
  }

  isExpanded(item: MenuItem): boolean {
    const key = item.link ?? item.label;
    return this.expanded.has(key) || this.isSectionActive(item);
  }

  onNavigate() {
    this.navigate.emit();
  }

 

}