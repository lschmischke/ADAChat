pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__serverguientrypoint.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__serverguientrypoint.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E072 : Short_Integer; pragma Import (Ada, E072, "system__os_lib_E");
   E011 : Short_Integer; pragma Import (Ada, E011, "system__soft_links_E");
   E021 : Short_Integer; pragma Import (Ada, E021, "system__exception_table_E");
   E422 : Short_Integer; pragma Import (Ada, E422, "ada__containers_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__io_exceptions_E");
   E426 : Short_Integer; pragma Import (Ada, E426, "ada__strings_E");
   E432 : Short_Integer; pragma Import (Ada, E432, "ada__strings__maps_E");
   E502 : Short_Integer; pragma Import (Ada, E502, "ada__strings__maps__constants_E");
   E043 : Short_Integer; pragma Import (Ada, E043, "ada__tags_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__streams_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "interfaces__c_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "interfaces__c__strings_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exceptions_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__file_control_block_E");
   E463 : Short_Integer; pragma Import (Ada, E463, "ada__streams__stream_io_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "system__file_io_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "system__finalization_root_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "ada__finalization_E");
   E091 : Short_Integer; pragma Import (Ada, E091, "system__storage_pools_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "system__finalization_masters_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "system__storage_pools__subpools_E");
   E378 : Short_Integer; pragma Import (Ada, E378, "system__task_info_E");
   E450 : Short_Integer; pragma Import (Ada, E450, "gnat__secure_hashes_E");
   E457 : Short_Integer; pragma Import (Ada, E457, "gnat__secure_hashes__sha2_common_E");
   E452 : Short_Integer; pragma Import (Ada, E452, "gnat__secure_hashes__sha2_64_E");
   E459 : Short_Integer; pragma Import (Ada, E459, "system__assertions_E");
   E093 : Short_Integer; pragma Import (Ada, E093, "system__pool_global_E");
   E467 : Short_Integer; pragma Import (Ada, E467, "gnat__sockets_E");
   E474 : Short_Integer; pragma Import (Ada, E474, "system__pool_size_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__secondary_stack_E");
   E428 : Short_Integer; pragma Import (Ada, E428, "ada__strings__unbounded_E");
   E448 : Short_Integer; pragma Import (Ada, E448, "gnat__sha512_E");
   E472 : Short_Integer; pragma Import (Ada, E472, "gnat__sockets__thin_common_E");
   E470 : Short_Integer; pragma Import (Ada, E470, "gnat__sockets__thin_E");
   E479 : Short_Integer; pragma Import (Ada, E479, "gnat__string_split_E");
   E461 : Short_Integer; pragma Import (Ada, E461, "system__strings__stream_ops_E");
   E392 : Short_Integer; pragma Import (Ada, E392, "system__tasking__initialization_E");
   E416 : Short_Integer; pragma Import (Ada, E416, "ada__real_time_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__text_io_E");
   E400 : Short_Integer; pragma Import (Ada, E400, "system__tasking__protected_objects_E");
   E404 : Short_Integer; pragma Import (Ada, E404, "system__tasking__protected_objects__entries_E");
   E408 : Short_Integer; pragma Import (Ada, E408, "system__tasking__queuing_E");
   E414 : Short_Integer; pragma Import (Ada, E414, "system__tasking__stages_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "glib_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "gtkada__types_E");
   E446 : Short_Integer; pragma Import (Ada, E446, "datatypes_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "gdk__frame_timings_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "glib__glist_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "gdk__visual_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "glib__gslist_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "glib__key_file_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "glib__object_E");
   E290 : Short_Integer; pragma Import (Ada, E290, "glib__string_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "glib__type_conversion_hooks_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "glib__types_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "glib__g_icon_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "glib__values_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "cairo_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "cairo__region_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gdk__color_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "gdk__rectangle_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "gdk__rgba_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "glib__generic_properties_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "gtk__editable_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "gtkada__c_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "gtkada__bindings_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "gdk__frame_clock_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "gdk__types_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "gdk__event_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "gdk__display_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "gdk__pixbuf_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "glib__properties_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "gdk__screen_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "gdk__device_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "gdk__drag_contexts_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "gdk__window_E");
   E288 : Short_Integer; pragma Import (Ada, E288, "glib__variant_E");
   E316 : Short_Integer; pragma Import (Ada, E316, "glib__menu_model_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "gtk__accel_group_E");
   E294 : Short_Integer; pragma Import (Ada, E294, "gtk__actionable_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "gtk__adjustment_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "gtk__builder_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "gtk__buildable_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "gtk__cell_area_context_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "gtk__cell_editable_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "gtk__css_section_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "gtk__entry_buffer_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "gtk__enums_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "gtk__icon_source_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "gtk__orientable_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "gtk__paper_size_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "gtk__page_setup_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "gtk__print_settings_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "gtk__scrollable_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "gtk__selection_data_E");
   E187 : Short_Integer; pragma Import (Ada, E187, "gtk__style_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "gtk__target_entry_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "gtk__target_list_E");
   E336 : Short_Integer; pragma Import (Ada, E336, "gtk__clipboard_E");
   E340 : Short_Integer; pragma Import (Ada, E340, "gtk__text_mark_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "gtk__tree_model_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "gtk__tree_drag_dest_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "gtk__tree_drag_source_E");
   E310 : Short_Integer; pragma Import (Ada, E310, "gtk__tree_sortable_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "gtk__list_store_E");
   E346 : Short_Integer; pragma Import (Ada, E346, "gtk__tree_store_E");
   E514 : Short_Integer; pragma Import (Ada, E514, "gtkada__builder_E");
   E480 : Short_Integer; pragma Import (Ada, E480, "gui_to_server_communication_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "pango__enums_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "pango__attributes_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "pango__font_metrics_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "pango__language_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "pango__font_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "gtk__text_attributes_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "gtk__text_tag_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "gtk__text_iter_E");
   E342 : Short_Integer; pragma Import (Ada, E342, "gtk__text_tag_table_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "pango__font_face_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "pango__font_family_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "pango__fontset_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "pango__matrix_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "pango__context_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "pango__font_map_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "pango__tabs_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "pango__layout_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "gtk__print_context_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "gtk__print_operation_preview_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "gtk__widget_E");
   E292 : Short_Integer; pragma Import (Ada, E292, "gtk__action_E");
   E296 : Short_Integer; pragma Import (Ada, E296, "gtk__activatable_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "gtk__cell_renderer_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "gtk__cell_layout_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "gtk__cell_area_E");
   E298 : Short_Integer; pragma Import (Ada, E298, "gtk__cell_renderer_text_E");
   E300 : Short_Integer; pragma Import (Ada, E300, "gtk__cell_renderer_toggle_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "gtk__container_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "gtk__bin_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "gtk__box_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "gtk__button_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "gtk__entry_completion_E");
   E302 : Short_Integer; pragma Import (Ada, E302, "gtk__frame_E");
   E326 : Short_Integer; pragma Import (Ada, E326, "gtk__grange_E");
   E312 : Short_Integer; pragma Import (Ada, E312, "gtk__main_E");
   E518 : Short_Integer; pragma Import (Ada, E518, "gtk__marshallers_E");
   E318 : Short_Integer; pragma Import (Ada, E318, "gtk__menu_item_E");
   E320 : Short_Integer; pragma Import (Ada, E320, "gtk__menu_shell_E");
   E314 : Short_Integer; pragma Import (Ada, E314, "gtk__menu_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "gtk__misc_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "gtk__notebook_E");
   E324 : Short_Integer; pragma Import (Ada, E324, "gtk__scrollbar_E");
   E322 : Short_Integer; pragma Import (Ada, E322, "gtk__scrolled_window_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "gtk__status_bar_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "gtk__style_provider_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "gtk__style_context_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "gtk__icon_set_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gtk__image_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "gtk__gentry_E");
   E328 : Short_Integer; pragma Import (Ada, E328, "gtk__spin_button_E");
   E338 : Short_Integer; pragma Import (Ada, E338, "gtk__text_child_anchor_E");
   E334 : Short_Integer; pragma Import (Ada, E334, "gtk__text_buffer_E");
   E330 : Short_Integer; pragma Import (Ada, E330, "gtk__text_view_E");
   E350 : Short_Integer; pragma Import (Ada, E350, "gtk__tooltip_E");
   E344 : Short_Integer; pragma Import (Ada, E344, "gtk__tree_selection_E");
   E352 : Short_Integer; pragma Import (Ada, E352, "gtk__tree_view_column_E");
   E348 : Short_Integer; pragma Import (Ada, E348, "gtk__tree_view_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "gtk__window_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "gtk__dialog_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "gtk__print_operation_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "gtk__arguments_E");
   E519 : Short_Integer; pragma Import (Ada, E519, "gtkada__handlers_E");
   E482 : Short_Integer; pragma Import (Ada, E482, "protocol_E");
   E521 : Short_Integer; pragma Import (Ada, E521, "serverguicallbacks_E");
   E506 : Short_Integer; pragma Import (Ada, E506, "user_databases_E");
   E495 : Short_Integer; pragma Import (Ada, E495, "server_to_gui_communication_E");
   E354 : Short_Integer; pragma Import (Ada, E354, "concrete_server_logic_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "concrete_server_gui_logic_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E077 := E077 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "concrete_server_gui_logic__finalize_spec");
      begin
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "concrete_server_logic__finalize_body");
      begin
         E354 := E354 - 1;
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "concrete_server_logic__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "server_to_gui_communication__finalize_spec");
      begin
         E495 := E495 - 1;
         F4;
      end;
      E506 := E506 - 1;
      declare
         procedure F5;
         pragma Import (Ada, F5, "user_databases__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gtkada__builder__finalize_body");
      begin
         E514 := E514 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtkada__handlers__finalize_spec");
      begin
         E519 := E519 - 1;
         F7;
      end;
      E177 := E177 - 1;
      E149 := E149 - 1;
      E316 := E316 - 1;
      E183 := E183 - 1;
      E165 := E165 - 1;
      E230 := E230 - 1;
      E187 := E187 - 1;
      E336 := E336 - 1;
      E242 := E242 - 1;
      E342 := E342 - 1;
      E169 := E169 - 1;
      E292 := E292 - 1;
      E240 := E240 - 1;
      E234 := E234 - 1;
      E298 := E298 - 1;
      E300 := E300 - 1;
      E163 := E163 - 1;
      E127 := E127 - 1;
      E232 := E232 - 1;
      E326 := E326 - 1;
      E318 := E318 - 1;
      E320 := E320 - 1;
      E314 := E314 - 1;
      E262 := E262 - 1;
      E322 := E322 - 1;
      E280 := E280 - 1;
      E250 := E250 - 1;
      E222 := E222 - 1;
      E328 := E328 - 1;
      E334 := E334 - 1;
      E330 := E330 - 1;
      E344 := E344 - 1;
      E352 := E352 - 1;
      E348 := E348 - 1;
      E216 := E216 - 1;
      E145 := E145 - 1;
      E264 := E264 - 1;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gtk__print_operation__finalize_spec");
      begin
         F8;
      end;
      declare
         procedure F9;
         pragma Import (Ada, F9, "gtk__dialog__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "gtk__window__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gtk__tree_view__finalize_spec");
      begin
         F11;
      end;
      declare
         procedure F12;
         pragma Import (Ada, F12, "gtk__tree_view_column__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtk__tree_selection__finalize_spec");
      begin
         F13;
      end;
      E350 := E350 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__tooltip__finalize_spec");
      begin
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtk__text_view__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__text_buffer__finalize_spec");
      begin
         F16;
      end;
      E338 := E338 - 1;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__text_child_anchor__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__spin_button__finalize_spec");
      begin
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__gentry__finalize_spec");
      begin
         F19;
      end;
      E244 := E244 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__image__finalize_spec");
      begin
         F20;
      end;
      E246 := E246 - 1;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__icon_set__finalize_spec");
      begin
         F21;
      end;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__style_context__finalize_spec");
      begin
         F22;
      end;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__status_bar__finalize_spec");
      begin
         F23;
      end;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__scrolled_window__finalize_spec");
      begin
         F24;
      end;
      E324 := E324 - 1;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__scrollbar__finalize_spec");
      begin
         F25;
      end;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__notebook__finalize_spec");
      begin
         F26;
      end;
      E256 := E256 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__misc__finalize_spec");
      begin
         F27;
      end;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__menu__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__menu_shell__finalize_spec");
      begin
         F29;
      end;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__menu_item__finalize_spec");
      begin
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__grange__finalize_spec");
      begin
         F31;
      end;
      E302 := E302 - 1;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__frame__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__entry_completion__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__button__finalize_spec");
      begin
         F34;
      end;
      E155 := E155 - 1;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__box__finalize_spec");
      begin
         F35;
      end;
      E220 := E220 - 1;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gtk__bin__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gtk__container__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__cell_renderer_toggle__finalize_spec");
      begin
         F38;
      end;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__cell_renderer_text__finalize_spec");
      begin
         F39;
      end;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gtk__cell_area__finalize_spec");
      begin
         F40;
      end;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gtk__cell_renderer__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__action__finalize_spec");
      begin
         F42;
      end;
      declare
         procedure F43;
         pragma Import (Ada, F43, "gtk__widget__finalize_spec");
      begin
         F43;
      end;
      E272 := E272 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "gtk__print_context__finalize_spec");
      begin
         F44;
      end;
      E208 := E208 - 1;
      declare
         procedure F45;
         pragma Import (Ada, F45, "pango__layout__finalize_spec");
      begin
         F45;
      end;
      E212 := E212 - 1;
      declare
         procedure F46;
         pragma Import (Ada, F46, "pango__tabs__finalize_spec");
      begin
         F46;
      end;
      E274 := E274 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "pango__font_map__finalize_spec");
      begin
         F47;
      end;
      E190 := E190 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "pango__context__finalize_spec");
      begin
         F48;
      end;
      E204 := E204 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "pango__fontset__finalize_spec");
      begin
         F49;
      end;
      E200 := E200 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "pango__font_family__finalize_spec");
      begin
         F50;
      end;
      E202 := E202 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "pango__font_face__finalize_spec");
      begin
         F51;
      end;
      declare
         procedure F52;
         pragma Import (Ada, F52, "gtk__text_tag_table__finalize_spec");
      begin
         F52;
      end;
      E286 := E286 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "gtk__text_tag__finalize_spec");
      begin
         F53;
      end;
      E194 := E194 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "pango__font__finalize_spec");
      begin
         F54;
      end;
      E198 := E198 - 1;
      declare
         procedure F55;
         pragma Import (Ada, F55, "pango__language__finalize_spec");
      begin
         F55;
      end;
      E196 := E196 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "pango__font_metrics__finalize_spec");
      begin
         F56;
      end;
      E210 := E210 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "pango__attributes__finalize_spec");
      begin
         F57;
      end;
      declare
         procedure F58;
         pragma Import (Ada, F58, "gtkada__builder__finalize_spec");
      begin
         F58;
      end;
      E346 := E346 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "gtk__tree_store__finalize_spec");
      begin
         F59;
      end;
      E304 := E304 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "gtk__list_store__finalize_spec");
      begin
         F60;
      end;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gtk__tree_model__finalize_spec");
      begin
         F61;
      end;
      E340 := E340 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "gtk__text_mark__finalize_spec");
      begin
         F62;
      end;
      declare
         procedure F63;
         pragma Import (Ada, F63, "gtk__clipboard__finalize_spec");
      begin
         F63;
      end;
      E258 := E258 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "gtk__target_list__finalize_spec");
      begin
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "gtk__style__finalize_spec");
      begin
         F65;
      end;
      E185 := E185 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "gtk__selection_data__finalize_spec");
      begin
         F66;
      end;
      E278 := E278 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "gtk__print_settings__finalize_spec");
      begin
         F67;
      end;
      E266 := E266 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "gtk__page_setup__finalize_spec");
      begin
         F68;
      end;
      E270 := E270 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "gtk__paper_size__finalize_spec");
      begin
         F69;
      end;
      E248 := E248 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "gtk__icon_source__finalize_spec");
      begin
         F70;
      end;
      declare
         procedure F71;
         pragma Import (Ada, F71, "gtk__entry_buffer__finalize_spec");
      begin
         F71;
      end;
      E252 := E252 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "gtk__css_section__finalize_spec");
      begin
         F72;
      end;
      E236 := E236 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "gtk__cell_area_context__finalize_spec");
      begin
         F73;
      end;
      E159 := E159 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "gtk__builder__finalize_spec");
      begin
         F74;
      end;
      declare
         procedure F75;
         pragma Import (Ada, F75, "gtk__adjustment__finalize_spec");
      begin
         F75;
      end;
      declare
         procedure F76;
         pragma Import (Ada, F76, "gtk__accel_group__finalize_spec");
      begin
         F76;
      end;
      declare
         procedure F77;
         pragma Import (Ada, F77, "glib__menu_model__finalize_spec");
      begin
         F77;
      end;
      E288 := E288 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "glib__variant__finalize_spec");
      begin
         F78;
      end;
      E175 := E175 - 1;
      declare
         procedure F79;
         pragma Import (Ada, F79, "gdk__drag_contexts__finalize_spec");
      begin
         F79;
      end;
      E173 := E173 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "gdk__device__finalize_spec");
      begin
         F80;
      end;
      E147 := E147 - 1;
      declare
         procedure F81;
         pragma Import (Ada, F81, "gdk__screen__finalize_spec");
      begin
         F81;
      end;
      E181 := E181 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "gdk__pixbuf__finalize_spec");
      begin
         F82;
      end;
      declare
         procedure F83;
         pragma Import (Ada, F83, "gdk__display__finalize_spec");
      begin
         F83;
      end;
      declare
         procedure F84;
         pragma Import (Ada, F84, "gdk__frame_clock__finalize_spec");
      begin
         F84;
      end;
      E099 := E099 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "glib__object__finalize_spec");
      begin
         F85;
      end;
      E179 := E179 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "gdk__frame_timings__finalize_spec");
      begin
         F86;
      end;
      E446 := E446 - 1;
      declare
         procedure F87;
         pragma Import (Ada, F87, "datatypes__finalize_spec");
      begin
         F87;
      end;
      E079 := E079 - 1;
      declare
         procedure F88;
         pragma Import (Ada, F88, "glib__finalize_spec");
      begin
         F88;
      end;
      E404 := E404 - 1;
      declare
         procedure F89;
         pragma Import (Ada, F89, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F89;
      end;
      E056 := E056 - 1;
      declare
         procedure F90;
         pragma Import (Ada, F90, "ada__text_io__finalize_spec");
      begin
         F90;
      end;
      declare
         procedure F91;
         pragma Import (Ada, F91, "gnat__sockets__finalize_body");
      begin
         E467 := E467 - 1;
         F91;
      end;
      E428 := E428 - 1;
      declare
         procedure F92;
         pragma Import (Ada, F92, "ada__strings__unbounded__finalize_spec");
      begin
         F92;
      end;
      declare
         procedure F93;
         pragma Import (Ada, F93, "system__file_io__finalize_body");
      begin
         E064 := E064 - 1;
         F93;
      end;
      E083 := E083 - 1;
      E103 := E103 - 1;
      E474 := E474 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "system__pool_size__finalize_spec");
      begin
         F94;
      end;
      declare
         procedure F95;
         pragma Import (Ada, F95, "gnat__sockets__finalize_spec");
      begin
         F95;
      end;
      E093 := E093 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "system__pool_global__finalize_spec");
      begin
         F96;
      end;
      declare
         procedure F97;
         pragma Import (Ada, F97, "system__storage_pools__subpools__finalize_spec");
      begin
         F97;
      end;
      declare
         procedure F98;
         pragma Import (Ada, F98, "system__finalization_masters__finalize_spec");
      begin
         F98;
      end;
      E463 := E463 - 1;
      declare
         procedure F99;
         pragma Import (Ada, F99, "ada__streams__stream_io__finalize_spec");
      begin
         F99;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, True, True, False, False, False, 
           False, False, False, True, True, True, False, False, 
           True, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, True, True, 
           False, True, False, False, True, False, True, False, 
           False, True, False, False, False, True, False, False, 
           True, True, False, True, True, False, False, False, 
           True, False, True, True, True, False, False, True, 
           False, False, True, False, True, True, False, True, 
           True, True, False, True, False, False, False, False, 
           False, True, True, False, False, False),
         Count => (0, 0, 0, 0, 0, 1, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E021 := E021 + 1;
      Ada.Containers'Elab_Spec;
      E422 := E422 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E059 := E059 + 1;
      Ada.Strings'Elab_Spec;
      E426 := E426 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E502 := E502 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E023 := E023 + 1;
      System.File_Control_Block'Elab_Spec;
      E075 := E075 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E463 := E463 + 1;
      System.Finalization_Root'Elab_Spec;
      E068 := E068 + 1;
      Ada.Finalization'Elab_Spec;
      E066 := E066 + 1;
      System.Storage_Pools'Elab_Spec;
      E091 := E091 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E378 := E378 + 1;
      E450 := E450 + 1;
      E457 := E457 + 1;
      Gnat.Secure_Hashes.Sha2_64'Elab_Spec;
      E452 := E452 + 1;
      System.Assertions'Elab_Spec;
      E459 := E459 + 1;
      System.Pool_Global'Elab_Spec;
      E093 := E093 + 1;
      Gnat.Sockets'Elab_Spec;
      System.Pool_Size'Elab_Spec;
      E474 := E474 + 1;
      E103 := E103 + 1;
      System.Finalization_Masters'Elab_Body;
      E083 := E083 + 1;
      System.File_Io'Elab_Body;
      E064 := E064 + 1;
      E081 := E081 + 1;
      E070 := E070 + 1;
      Ada.Tags'Elab_Body;
      E043 := E043 + 1;
      E432 := E432 + 1;
      System.Soft_Links'Elab_Body;
      E011 := E011 + 1;
      System.Os_Lib'Elab_Body;
      E072 := E072 + 1;
      System.Secondary_Stack'Elab_Body;
      E015 := E015 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E428 := E428 + 1;
      Gnat.Sha512'Elab_Spec;
      E448 := E448 + 1;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E472 := E472 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E470 := E470 + 1;
      Gnat.Sockets'Elab_Body;
      E467 := E467 + 1;
      Gnat.String_Split'Elab_Spec;
      E479 := E479 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E461 := E461 + 1;
      System.Tasking.Initialization'Elab_Body;
      E392 := E392 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E416 := E416 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E056 := E056 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E400 := E400 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E404 := E404 + 1;
      System.Tasking.Queuing'Elab_Body;
      E408 := E408 + 1;
      System.Tasking.Stages'Elab_Body;
      E414 := E414 + 1;
      Glib'Elab_Spec;
      E079 := E079 + 1;
      Gtkada.Types'Elab_Spec;
      E120 := E120 + 1;
      Datatypes'Elab_Spec;
      E446 := E446 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      E179 := E179 + 1;
      E122 := E122 + 1;
      Gdk.Visual'Elab_Spec;
      Gdk.Visual'Elab_Body;
      E151 := E151 + 1;
      E124 := E124 + 1;
      Glib.Object'Elab_Spec;
      E101 := E101 + 1;
      Glib.Values'Elab_Body;
      E116 := E116 + 1;
      E131 := E131 + 1;
      E133 := E133 + 1;
      Gdk.Color'Elab_Spec;
      E138 := E138 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E141 := E141 + 1;
      E118 := E118 + 1;
      Gtkada.Bindings'Elab_Spec;
      E108 := E108 + 1;
      E224 := E224 + 1;
      E114 := E114 + 1;
      E290 := E290 + 1;
      Glib.Object'Elab_Body;
      E099 := E099 + 1;
      Gdk.Rgba'Elab_Body;
      E143 := E143 + 1;
      Gdk.Color'Elab_Body;
      E171 := E171 + 1;
      E268 := E268 + 1;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Types'Elab_Spec;
      E139 := E139 + 1;
      Gdk.Event'Elab_Spec;
      E136 := E136 + 1;
      Gdk.Display'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      E181 := E181 + 1;
      Glib.Properties'Elab_Spec;
      E153 := E153 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E147 := E147 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Device'Elab_Body;
      E173 := E173 + 1;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E175 := E175 + 1;
      Gdk.Window'Elab_Spec;
      E218 := E218 + 1;
      Glib.Variant'Elab_Spec;
      E288 := E288 + 1;
      Glib.Menu_Model'Elab_Spec;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Actionable'Elab_Spec;
      E294 := E294 + 1;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E159 := E159 + 1;
      E157 := E157 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E236 := E236 + 1;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Css_Section'Elab_Spec;
      E252 := E252 + 1;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Enums'Elab_Spec;
      E167 := E167 + 1;
      Gtk.Icon_Source'Elab_Spec;
      E248 := E248 + 1;
      Gtk.Orientable'Elab_Spec;
      E214 := E214 + 1;
      Gtk.Paper_Size'Elab_Spec;
      E270 := E270 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E266 := E266 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E278 := E278 + 1;
      Gtk.Scrollable'Elab_Spec;
      E332 := E332 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E185 := E185 + 1;
      Gtk.Style'Elab_Spec;
      E260 := E260 + 1;
      Gtk.Target_List'Elab_Spec;
      E258 := E258 + 1;
      Gtk.Clipboard'Elab_Spec;
      Gtk.Text_Mark'Elab_Spec;
      Gtk.Text_Mark'Elab_Body;
      E340 := E340 + 1;
      Gtk.Tree_Model'Elab_Spec;
      E306 := E306 + 1;
      E308 := E308 + 1;
      Gtk.List_Store'Elab_Spec;
      Gtk.List_Store'Elab_Body;
      E304 := E304 + 1;
      Gtk.Tree_Store'Elab_Spec;
      Gtk.Tree_Store'Elab_Body;
      E346 := E346 + 1;
      Gtkada.Builder'Elab_Spec;
      Gui_To_Server_Communication'Elab_Spec;
      E480 := E480 + 1;
      Pango.Enums'Elab_Spec;
      E192 := E192 + 1;
      Pango.Attributes'Elab_Spec;
      E210 := E210 + 1;
      Pango.Font_Metrics'Elab_Spec;
      E196 := E196 + 1;
      Pango.Language'Elab_Spec;
      E198 := E198 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E194 := E194 + 1;
      E284 := E284 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E286 := E286 + 1;
      Gtk.Text_Iter'Elab_Spec;
      E282 := E282 + 1;
      Gtk.Text_Tag_Table'Elab_Spec;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E202 := E202 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E200 := E200 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E204 := E204 + 1;
      E206 := E206 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E190 := E190 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E274 := E274 + 1;
      Pango.Tabs'Elab_Spec;
      E212 := E212 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E208 := E208 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E272 := E272 + 1;
      Gtk.Widget'Elab_Spec;
      Gtk.Action'Elab_Spec;
      Gtk.Activatable'Elab_Spec;
      E296 := E296 + 1;
      Gtk.Cell_Renderer'Elab_Spec;
      E238 := E238 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Cell_Renderer_Text'Elab_Spec;
      Gtk.Cell_Renderer_Toggle'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E220 := E220 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E155 := E155 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Frame'Elab_Spec;
      Gtk.Frame'Elab_Body;
      E302 := E302 + 1;
      Gtk.Grange'Elab_Spec;
      E312 := E312 + 1;
      E518 := E518 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E256 := E256 + 1;
      Gtk.Notebook'Elab_Spec;
      Gtk.Scrollbar'Elab_Spec;
      Gtk.Scrollbar'Elab_Body;
      E324 := E324 + 1;
      Gtk.Scrolled_Window'Elab_Spec;
      Gtk.Status_Bar'Elab_Spec;
      E254 := E254 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      E246 := E246 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E244 := E244 + 1;
      Gtk.Gentry'Elab_Spec;
      Gtk.Spin_Button'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Body;
      E338 := E338 + 1;
      Gtk.Text_Buffer'Elab_Spec;
      Gtk.Text_View'Elab_Spec;
      Gtk.Tooltip'Elab_Spec;
      Gtk.Tooltip'Elab_Body;
      E350 := E350 + 1;
      Gtk.Tree_Selection'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      Gtk.Arguments'Elab_Spec;
      E129 := E129 + 1;
      Gtk.Print_Operation'Elab_Body;
      E264 := E264 + 1;
      Gtk.Dialog'Elab_Body;
      E145 := E145 + 1;
      Gtk.Window'Elab_Body;
      E216 := E216 + 1;
      Gtk.Tree_View'Elab_Body;
      E348 := E348 + 1;
      Gtk.Tree_View_Column'Elab_Body;
      E352 := E352 + 1;
      Gtk.Tree_Selection'Elab_Body;
      E344 := E344 + 1;
      Gtk.Text_View'Elab_Body;
      E330 := E330 + 1;
      Gtk.Text_Buffer'Elab_Body;
      E334 := E334 + 1;
      Gtk.Spin_Button'Elab_Body;
      E328 := E328 + 1;
      Gtk.Gentry'Elab_Body;
      E222 := E222 + 1;
      Gtk.Style_Context'Elab_Body;
      E250 := E250 + 1;
      Gtk.Status_Bar'Elab_Body;
      E280 := E280 + 1;
      Gtk.Scrolled_Window'Elab_Body;
      E322 := E322 + 1;
      Gtk.Notebook'Elab_Body;
      E262 := E262 + 1;
      Gtk.Menu'Elab_Body;
      E314 := E314 + 1;
      Gtk.Menu_Shell'Elab_Body;
      E320 := E320 + 1;
      Gtk.Menu_Item'Elab_Body;
      E318 := E318 + 1;
      Gtk.Grange'Elab_Body;
      E326 := E326 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E232 := E232 + 1;
      Gtk.Button'Elab_Body;
      E127 := E127 + 1;
      Gtk.Container'Elab_Body;
      E163 := E163 + 1;
      Gtk.Cell_Renderer_Toggle'Elab_Body;
      E300 := E300 + 1;
      Gtk.Cell_Renderer_Text'Elab_Body;
      E298 := E298 + 1;
      Gtk.Cell_Area'Elab_Body;
      E234 := E234 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E240 := E240 + 1;
      Gtk.Action'Elab_Body;
      E292 := E292 + 1;
      Gtk.Widget'Elab_Body;
      E169 := E169 + 1;
      E276 := E276 + 1;
      Gtk.Text_Tag_Table'Elab_Body;
      E342 := E342 + 1;
      E310 := E310 + 1;
      E242 := E242 + 1;
      Gtk.Clipboard'Elab_Body;
      E336 := E336 + 1;
      Gtk.Style'Elab_Body;
      E187 := E187 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E230 := E230 + 1;
      E226 := E226 + 1;
      Gtk.Adjustment'Elab_Body;
      E165 := E165 + 1;
      Gtk.Accel_Group'Elab_Body;
      E183 := E183 + 1;
      Glib.Menu_Model'Elab_Body;
      E316 := E316 + 1;
      Gdk.Display'Elab_Body;
      E149 := E149 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E177 := E177 + 1;
      E228 := E228 + 1;
      Gtkada.Handlers'Elab_Spec;
      E519 := E519 + 1;
      Gtkada.Builder'Elab_Body;
      E514 := E514 + 1;
      E482 := E482 + 1;
      Serverguicallbacks'Elab_Body;
      E521 := E521 + 1;
      User_Databases'Elab_Spec;
      E506 := E506 + 1;
      Server_To_Gui_Communication'Elab_Spec;
      E495 := E495 + 1;
      Concrete_Server_Logic'Elab_Spec;
      Concrete_Server_Logic'Elab_Body;
      E354 := E354 + 1;
      Concrete_Server_Gui_Logic'Elab_Spec;
      Concrete_Server_Gui_Logic'Elab_Body;
      E077 := E077 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_serverguientrypoint");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   C:\Users\Leonard\Documents\ADA\adachat\datatypes.o
   --   C:\Users\Leonard\Documents\ADA\adachat\gui_to_server_communication.o
   --   C:\Users\Leonard\Documents\ADA\adachat\protocol.o
   --   C:\Users\Leonard\Documents\ADA\adachat\ServerGuiCallbacks.o
   --   C:\Users\Leonard\Documents\ADA\adachat\user_databases.o
   --   C:\Users\Leonard\Documents\ADA\adachat\server_to_gui_communication.o
   --   C:\Users\Leonard\Documents\ADA\adachat\concrete_server_logic.o
   --   C:\Users\Leonard\Documents\ADA\adachat\concrete_server_gui_logic.o
   --   C:\Users\Leonard\Documents\ADA\adachat\ServerGuiEntryPoint.o
   --   -LC:\Users\Leonard\Documents\ADA\adachat\
   --   -LC:\Users\Leonard\Documents\ADA\adachat\
   --   -LC:\GtkAda\lib\gtkada\static\
   --   -LC:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -shared-libgcc
   --   -lgnarl
   --   -lgnat
   --   -lws2_32
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
