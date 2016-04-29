pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E111 : Short_Integer; pragma Import (Ada, E111, "system__os_lib_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__soft_links_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "system__exception_table_E");
   E391 : Short_Integer; pragma Import (Ada, E391, "ada__containers_E");
   E084 : Short_Integer; pragma Import (Ada, E084, "ada__io_exceptions_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__strings_E");
   E048 : Short_Integer; pragma Import (Ada, E048, "ada__strings__maps_E");
   E442 : Short_Integer; pragma Import (Ada, E442, "ada__strings__maps__constants_E");
   E055 : Short_Integer; pragma Import (Ada, E055, "ada__tags_E");
   E083 : Short_Integer; pragma Import (Ada, E083, "ada__streams_E");
   E109 : Short_Integer; pragma Import (Ada, E109, "interfaces__c_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "interfaces__c__strings_E");
   E022 : Short_Integer; pragma Import (Ada, E022, "system__exceptions_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "system__file_control_block_E");
   E400 : Short_Integer; pragma Import (Ada, E400, "ada__streams__stream_io_E");
   E107 : Short_Integer; pragma Import (Ada, E107, "system__file_io_E");
   E086 : Short_Integer; pragma Import (Ada, E086, "system__finalization_root_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "ada__finalization_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__storage_pools_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__finalization_masters_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__storage_pools__subpools_E");
   E464 : Short_Integer; pragma Import (Ada, E464, "system__task_info_E");
   E508 : Short_Integer; pragma Import (Ada, E508, "gnat__secure_hashes_E");
   E515 : Short_Integer; pragma Import (Ada, E515, "gnat__secure_hashes__sha2_common_E");
   E510 : Short_Integer; pragma Import (Ada, E510, "gnat__secure_hashes__sha2_64_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "system__assertions_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "system__pool_global_E");
   E420 : Short_Integer; pragma Import (Ada, E420, "gnat__sockets_E");
   E427 : Short_Integer; pragma Import (Ada, E427, "system__pool_size_E");
   E014 : Short_Integer; pragma Import (Ada, E014, "system__secondary_stack_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "ada__strings__unbounded_E");
   E506 : Short_Integer; pragma Import (Ada, E506, "gnat__sha512_E");
   E425 : Short_Integer; pragma Import (Ada, E425, "gnat__sockets__thin_common_E");
   E423 : Short_Integer; pragma Import (Ada, E423, "gnat__sockets__thin_E");
   E432 : Short_Integer; pragma Import (Ada, E432, "gnat__string_split_E");
   E398 : Short_Integer; pragma Import (Ada, E398, "system__strings__stream_ops_E");
   E476 : Short_Integer; pragma Import (Ada, E476, "system__tasking__initialization_E");
   E500 : Short_Integer; pragma Import (Ada, E500, "ada__real_time_E");
   E102 : Short_Integer; pragma Import (Ada, E102, "ada__text_io_E");
   E484 : Short_Integer; pragma Import (Ada, E484, "system__tasking__protected_objects_E");
   E488 : Short_Integer; pragma Import (Ada, E488, "system__tasking__protected_objects__entries_E");
   E492 : Short_Integer; pragma Import (Ada, E492, "system__tasking__queuing_E");
   E498 : Short_Integer; pragma Import (Ada, E498, "system__tasking__stages_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "glib_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "gtkada__types_E");
   E096 : Short_Integer; pragma Import (Ada, E096, "client_logic_E");
   E098 : Short_Integer; pragma Import (Ada, E098, "client_ui_E");
   E504 : Short_Integer; pragma Import (Ada, E504, "datatypes_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "gdk__frame_timings_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "glib__glist_E");
   E174 : Short_Integer; pragma Import (Ada, E174, "gdk__visual_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "glib__gslist_E");
   E291 : Short_Integer; pragma Import (Ada, E291, "glib__key_file_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "glib__object_E");
   E313 : Short_Integer; pragma Import (Ada, E313, "glib__string_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "glib__type_conversion_hooks_E");
   E137 : Short_Integer; pragma Import (Ada, E137, "glib__types_E");
   E247 : Short_Integer; pragma Import (Ada, E247, "glib__g_icon_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "glib__values_E");
   E154 : Short_Integer; pragma Import (Ada, E154, "cairo_E");
   E156 : Short_Integer; pragma Import (Ada, E156, "cairo__region_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "gdk__color_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "gdk__rectangle_E");
   E166 : Short_Integer; pragma Import (Ada, E166, "gdk__rgba_E");
   E164 : Short_Integer; pragma Import (Ada, E164, "glib__generic_properties_E");
   E251 : Short_Integer; pragma Import (Ada, E251, "gtk__editable_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "gtkada__c_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "gtkada__bindings_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "gdk__frame_clock_E");
   E162 : Short_Integer; pragma Import (Ada, E162, "gdk__types_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "gdk__event_E");
   E172 : Short_Integer; pragma Import (Ada, E172, "gdk__display_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "gdk__pixbuf_E");
   E176 : Short_Integer; pragma Import (Ada, E176, "glib__properties_E");
   E170 : Short_Integer; pragma Import (Ada, E170, "gdk__screen_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "gdk__device_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "gdk__drag_contexts_E");
   E241 : Short_Integer; pragma Import (Ada, E241, "gdk__window_E");
   E311 : Short_Integer; pragma Import (Ada, E311, "glib__variant_E");
   E339 : Short_Integer; pragma Import (Ada, E339, "glib__menu_model_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "gtk__accel_group_E");
   E317 : Short_Integer; pragma Import (Ada, E317, "gtk__actionable_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "gtk__adjustment_E");
   E182 : Short_Integer; pragma Import (Ada, E182, "gtk__builder_E");
   E180 : Short_Integer; pragma Import (Ada, E180, "gtk__buildable_E");
   E259 : Short_Integer; pragma Import (Ada, E259, "gtk__cell_area_context_E");
   E249 : Short_Integer; pragma Import (Ada, E249, "gtk__cell_editable_E");
   E275 : Short_Integer; pragma Import (Ada, E275, "gtk__css_section_E");
   E253 : Short_Integer; pragma Import (Ada, E253, "gtk__entry_buffer_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "gtk__enums_E");
   E271 : Short_Integer; pragma Import (Ada, E271, "gtk__icon_source_E");
   E237 : Short_Integer; pragma Import (Ada, E237, "gtk__orientable_E");
   E293 : Short_Integer; pragma Import (Ada, E293, "gtk__paper_size_E");
   E289 : Short_Integer; pragma Import (Ada, E289, "gtk__page_setup_E");
   E301 : Short_Integer; pragma Import (Ada, E301, "gtk__print_settings_E");
   E355 : Short_Integer; pragma Import (Ada, E355, "gtk__scrollable_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "gtk__selection_data_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "gtk__style_E");
   E283 : Short_Integer; pragma Import (Ada, E283, "gtk__target_entry_E");
   E281 : Short_Integer; pragma Import (Ada, E281, "gtk__target_list_E");
   E359 : Short_Integer; pragma Import (Ada, E359, "gtk__clipboard_E");
   E363 : Short_Integer; pragma Import (Ada, E363, "gtk__text_mark_E");
   E265 : Short_Integer; pragma Import (Ada, E265, "gtk__tree_model_E");
   E329 : Short_Integer; pragma Import (Ada, E329, "gtk__tree_drag_dest_E");
   E331 : Short_Integer; pragma Import (Ada, E331, "gtk__tree_drag_source_E");
   E333 : Short_Integer; pragma Import (Ada, E333, "gtk__tree_sortable_E");
   E327 : Short_Integer; pragma Import (Ada, E327, "gtk__list_store_E");
   E369 : Short_Integer; pragma Import (Ada, E369, "gtk__tree_store_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "gtkada__builder_E");
   E516 : Short_Integer; pragma Import (Ada, E516, "gui_to_server_communication_E");
   E215 : Short_Integer; pragma Import (Ada, E215, "pango__enums_E");
   E233 : Short_Integer; pragma Import (Ada, E233, "pango__attributes_E");
   E219 : Short_Integer; pragma Import (Ada, E219, "pango__font_metrics_E");
   E221 : Short_Integer; pragma Import (Ada, E221, "pango__language_E");
   E217 : Short_Integer; pragma Import (Ada, E217, "pango__font_E");
   E307 : Short_Integer; pragma Import (Ada, E307, "gtk__text_attributes_E");
   E309 : Short_Integer; pragma Import (Ada, E309, "gtk__text_tag_E");
   E305 : Short_Integer; pragma Import (Ada, E305, "gtk__text_iter_E");
   E365 : Short_Integer; pragma Import (Ada, E365, "gtk__text_tag_table_E");
   E225 : Short_Integer; pragma Import (Ada, E225, "pango__font_face_E");
   E223 : Short_Integer; pragma Import (Ada, E223, "pango__font_family_E");
   E227 : Short_Integer; pragma Import (Ada, E227, "pango__fontset_E");
   E229 : Short_Integer; pragma Import (Ada, E229, "pango__matrix_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "pango__context_E");
   E297 : Short_Integer; pragma Import (Ada, E297, "pango__font_map_E");
   E235 : Short_Integer; pragma Import (Ada, E235, "pango__tabs_E");
   E231 : Short_Integer; pragma Import (Ada, E231, "pango__layout_E");
   E295 : Short_Integer; pragma Import (Ada, E295, "gtk__print_context_E");
   E299 : Short_Integer; pragma Import (Ada, E299, "gtk__print_operation_preview_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "gtk__widget_E");
   E315 : Short_Integer; pragma Import (Ada, E315, "gtk__action_E");
   E319 : Short_Integer; pragma Import (Ada, E319, "gtk__activatable_E");
   E263 : Short_Integer; pragma Import (Ada, E263, "gtk__cell_renderer_E");
   E261 : Short_Integer; pragma Import (Ada, E261, "gtk__cell_layout_E");
   E257 : Short_Integer; pragma Import (Ada, E257, "gtk__cell_area_E");
   E321 : Short_Integer; pragma Import (Ada, E321, "gtk__cell_renderer_text_E");
   E323 : Short_Integer; pragma Import (Ada, E323, "gtk__cell_renderer_toggle_E");
   E186 : Short_Integer; pragma Import (Ada, E186, "gtk__container_E");
   E243 : Short_Integer; pragma Import (Ada, E243, "gtk__bin_E");
   E178 : Short_Integer; pragma Import (Ada, E178, "gtk__box_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "gtk__button_E");
   E255 : Short_Integer; pragma Import (Ada, E255, "gtk__entry_completion_E");
   E325 : Short_Integer; pragma Import (Ada, E325, "gtk__frame_E");
   E349 : Short_Integer; pragma Import (Ada, E349, "gtk__grange_E");
   E335 : Short_Integer; pragma Import (Ada, E335, "gtk__main_E");
   E387 : Short_Integer; pragma Import (Ada, E387, "gtk__marshallers_E");
   E341 : Short_Integer; pragma Import (Ada, E341, "gtk__menu_item_E");
   E343 : Short_Integer; pragma Import (Ada, E343, "gtk__menu_shell_E");
   E337 : Short_Integer; pragma Import (Ada, E337, "gtk__menu_E");
   E279 : Short_Integer; pragma Import (Ada, E279, "gtk__misc_E");
   E285 : Short_Integer; pragma Import (Ada, E285, "gtk__notebook_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "gtk__scrollbar_E");
   E345 : Short_Integer; pragma Import (Ada, E345, "gtk__scrolled_window_E");
   E532 : Short_Integer; pragma Import (Ada, E532, "gtk__size_group_E");
   E303 : Short_Integer; pragma Import (Ada, E303, "gtk__status_bar_E");
   E277 : Short_Integer; pragma Import (Ada, E277, "gtk__style_provider_E");
   E273 : Short_Integer; pragma Import (Ada, E273, "gtk__style_context_E");
   E269 : Short_Integer; pragma Import (Ada, E269, "gtk__icon_set_E");
   E267 : Short_Integer; pragma Import (Ada, E267, "gtk__image_E");
   E245 : Short_Integer; pragma Import (Ada, E245, "gtk__gentry_E");
   E351 : Short_Integer; pragma Import (Ada, E351, "gtk__spin_button_E");
   E361 : Short_Integer; pragma Import (Ada, E361, "gtk__text_child_anchor_E");
   E357 : Short_Integer; pragma Import (Ada, E357, "gtk__text_buffer_E");
   E353 : Short_Integer; pragma Import (Ada, E353, "gtk__text_view_E");
   E530 : Short_Integer; pragma Import (Ada, E530, "gtk__tool_item_E");
   E528 : Short_Integer; pragma Import (Ada, E528, "gtk__tool_button_E");
   E373 : Short_Integer; pragma Import (Ada, E373, "gtk__tooltip_E");
   E367 : Short_Integer; pragma Import (Ada, E367, "gtk__tree_selection_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "gtk__tree_view_column_E");
   E371 : Short_Integer; pragma Import (Ada, E371, "gtk__tree_view_E");
   E239 : Short_Integer; pragma Import (Ada, E239, "gtk__window_E");
   E168 : Short_Integer; pragma Import (Ada, E168, "gtk__dialog_E");
   E287 : Short_Integer; pragma Import (Ada, E287, "gtk__print_operation_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "gtk__arguments_E");
   E388 : Short_Integer; pragma Import (Ada, E388, "gtkada__handlers_E");
   E404 : Short_Integer; pragma Import (Ada, E404, "protocol_E");
   E526 : Short_Integer; pragma Import (Ada, E526, "serverguicallbacks_E");
   E100 : Short_Integer; pragma Import (Ada, E100, "serverguientrypoint_E");
   E518 : Short_Integer; pragma Import (Ada, E518, "user_databases_E");
   E433 : Short_Integer; pragma Import (Ada, E433, "server_to_gui_communication_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "concrete_server_gui_logic_E");
   E446 : Short_Integer; pragma Import (Ada, E446, "concrete_server_logic_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "concrete_server_logic__finalize_body");
      begin
         E446 := E446 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "concrete_server_logic__finalize_spec");
      begin
         F2;
      end;
      E116 := E116 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "concrete_server_gui_logic__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "server_to_gui_communication__finalize_spec");
      begin
         E433 := E433 - 1;
         F4;
      end;
      E518 := E518 - 1;
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
         E381 := E381 - 1;
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtkada__handlers__finalize_spec");
      begin
         E388 := E388 - 1;
         F7;
      end;
      E200 := E200 - 1;
      E172 := E172 - 1;
      E339 := E339 - 1;
      E206 := E206 - 1;
      E188 := E188 - 1;
      E253 := E253 - 1;
      E210 := E210 - 1;
      E359 := E359 - 1;
      E265 := E265 - 1;
      E365 := E365 - 1;
      E192 := E192 - 1;
      E315 := E315 - 1;
      E263 := E263 - 1;
      E257 := E257 - 1;
      E321 := E321 - 1;
      E323 := E323 - 1;
      E186 := E186 - 1;
      E150 := E150 - 1;
      E255 := E255 - 1;
      E349 := E349 - 1;
      E341 := E341 - 1;
      E343 := E343 - 1;
      E337 := E337 - 1;
      E285 := E285 - 1;
      E345 := E345 - 1;
      E303 := E303 - 1;
      E273 := E273 - 1;
      E245 := E245 - 1;
      E351 := E351 - 1;
      E357 := E357 - 1;
      E353 := E353 - 1;
      E530 := E530 - 1;
      E528 := E528 - 1;
      E367 := E367 - 1;
      E375 := E375 - 1;
      E371 := E371 - 1;
      E239 := E239 - 1;
      E168 := E168 - 1;
      E287 := E287 - 1;
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
      E373 := E373 - 1;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__tooltip__finalize_spec");
      begin
         F14;
      end;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtk__tool_button__finalize_spec");
      begin
         F15;
      end;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__tool_item__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__text_view__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__text_buffer__finalize_spec");
      begin
         F18;
      end;
      E361 := E361 - 1;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__text_child_anchor__finalize_spec");
      begin
         F19;
      end;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__spin_button__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__gentry__finalize_spec");
      begin
         F21;
      end;
      E267 := E267 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__image__finalize_spec");
      begin
         F22;
      end;
      E269 := E269 - 1;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__icon_set__finalize_spec");
      begin
         F23;
      end;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__style_context__finalize_spec");
      begin
         F24;
      end;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__status_bar__finalize_spec");
      begin
         F25;
      end;
      E532 := E532 - 1;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__size_group__finalize_spec");
      begin
         F26;
      end;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__scrolled_window__finalize_spec");
      begin
         F27;
      end;
      E347 := E347 - 1;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__scrollbar__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__notebook__finalize_spec");
      begin
         F29;
      end;
      E279 := E279 - 1;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__misc__finalize_spec");
      begin
         F30;
      end;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__menu__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__menu_shell__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__menu_item__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__grange__finalize_spec");
      begin
         F34;
      end;
      E325 := E325 - 1;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__frame__finalize_spec");
      begin
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gtk__entry_completion__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gtk__button__finalize_spec");
      begin
         F37;
      end;
      E178 := E178 - 1;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__box__finalize_spec");
      begin
         F38;
      end;
      E243 := E243 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__bin__finalize_spec");
      begin
         F39;
      end;
      declare
         procedure F40;
         pragma Import (Ada, F40, "gtk__container__finalize_spec");
      begin
         F40;
      end;
      declare
         procedure F41;
         pragma Import (Ada, F41, "gtk__cell_renderer_toggle__finalize_spec");
      begin
         F41;
      end;
      declare
         procedure F42;
         pragma Import (Ada, F42, "gtk__cell_renderer_text__finalize_spec");
      begin
         F42;
      end;
      declare
         procedure F43;
         pragma Import (Ada, F43, "gtk__cell_area__finalize_spec");
      begin
         F43;
      end;
      declare
         procedure F44;
         pragma Import (Ada, F44, "gtk__cell_renderer__finalize_spec");
      begin
         F44;
      end;
      declare
         procedure F45;
         pragma Import (Ada, F45, "gtk__action__finalize_spec");
      begin
         F45;
      end;
      declare
         procedure F46;
         pragma Import (Ada, F46, "gtk__widget__finalize_spec");
      begin
         F46;
      end;
      E295 := E295 - 1;
      declare
         procedure F47;
         pragma Import (Ada, F47, "gtk__print_context__finalize_spec");
      begin
         F47;
      end;
      E231 := E231 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "pango__layout__finalize_spec");
      begin
         F48;
      end;
      E235 := E235 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "pango__tabs__finalize_spec");
      begin
         F49;
      end;
      E297 := E297 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "pango__font_map__finalize_spec");
      begin
         F50;
      end;
      E213 := E213 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "pango__context__finalize_spec");
      begin
         F51;
      end;
      E227 := E227 - 1;
      declare
         procedure F52;
         pragma Import (Ada, F52, "pango__fontset__finalize_spec");
      begin
         F52;
      end;
      E223 := E223 - 1;
      declare
         procedure F53;
         pragma Import (Ada, F53, "pango__font_family__finalize_spec");
      begin
         F53;
      end;
      E225 := E225 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "pango__font_face__finalize_spec");
      begin
         F54;
      end;
      declare
         procedure F55;
         pragma Import (Ada, F55, "gtk__text_tag_table__finalize_spec");
      begin
         F55;
      end;
      E309 := E309 - 1;
      declare
         procedure F56;
         pragma Import (Ada, F56, "gtk__text_tag__finalize_spec");
      begin
         F56;
      end;
      E217 := E217 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "pango__font__finalize_spec");
      begin
         F57;
      end;
      E221 := E221 - 1;
      declare
         procedure F58;
         pragma Import (Ada, F58, "pango__language__finalize_spec");
      begin
         F58;
      end;
      E219 := E219 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "pango__font_metrics__finalize_spec");
      begin
         F59;
      end;
      E233 := E233 - 1;
      declare
         procedure F60;
         pragma Import (Ada, F60, "pango__attributes__finalize_spec");
      begin
         F60;
      end;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gui_to_server_communication__finalize_spec");
      begin
         E516 := E516 - 1;
         F61;
      end;
      declare
         procedure F62;
         pragma Import (Ada, F62, "gtkada__builder__finalize_spec");
      begin
         F62;
      end;
      E369 := E369 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "gtk__tree_store__finalize_spec");
      begin
         F63;
      end;
      E327 := E327 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "gtk__list_store__finalize_spec");
      begin
         F64;
      end;
      declare
         procedure F65;
         pragma Import (Ada, F65, "gtk__tree_model__finalize_spec");
      begin
         F65;
      end;
      E363 := E363 - 1;
      declare
         procedure F66;
         pragma Import (Ada, F66, "gtk__text_mark__finalize_spec");
      begin
         F66;
      end;
      declare
         procedure F67;
         pragma Import (Ada, F67, "gtk__clipboard__finalize_spec");
      begin
         F67;
      end;
      E281 := E281 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "gtk__target_list__finalize_spec");
      begin
         F68;
      end;
      declare
         procedure F69;
         pragma Import (Ada, F69, "gtk__style__finalize_spec");
      begin
         F69;
      end;
      E208 := E208 - 1;
      declare
         procedure F70;
         pragma Import (Ada, F70, "gtk__selection_data__finalize_spec");
      begin
         F70;
      end;
      E301 := E301 - 1;
      declare
         procedure F71;
         pragma Import (Ada, F71, "gtk__print_settings__finalize_spec");
      begin
         F71;
      end;
      E289 := E289 - 1;
      declare
         procedure F72;
         pragma Import (Ada, F72, "gtk__page_setup__finalize_spec");
      begin
         F72;
      end;
      E293 := E293 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "gtk__paper_size__finalize_spec");
      begin
         F73;
      end;
      E271 := E271 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "gtk__icon_source__finalize_spec");
      begin
         F74;
      end;
      declare
         procedure F75;
         pragma Import (Ada, F75, "gtk__entry_buffer__finalize_spec");
      begin
         F75;
      end;
      E275 := E275 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "gtk__css_section__finalize_spec");
      begin
         F76;
      end;
      E259 := E259 - 1;
      declare
         procedure F77;
         pragma Import (Ada, F77, "gtk__cell_area_context__finalize_spec");
      begin
         F77;
      end;
      E182 := E182 - 1;
      declare
         procedure F78;
         pragma Import (Ada, F78, "gtk__builder__finalize_spec");
      begin
         F78;
      end;
      declare
         procedure F79;
         pragma Import (Ada, F79, "gtk__adjustment__finalize_spec");
      begin
         F79;
      end;
      declare
         procedure F80;
         pragma Import (Ada, F80, "gtk__accel_group__finalize_spec");
      begin
         F80;
      end;
      declare
         procedure F81;
         pragma Import (Ada, F81, "glib__menu_model__finalize_spec");
      begin
         F81;
      end;
      E311 := E311 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "glib__variant__finalize_spec");
      begin
         F82;
      end;
      E198 := E198 - 1;
      declare
         procedure F83;
         pragma Import (Ada, F83, "gdk__drag_contexts__finalize_spec");
      begin
         F83;
      end;
      E196 := E196 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "gdk__device__finalize_spec");
      begin
         F84;
      end;
      E170 := E170 - 1;
      declare
         procedure F85;
         pragma Import (Ada, F85, "gdk__screen__finalize_spec");
      begin
         F85;
      end;
      E204 := E204 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "gdk__pixbuf__finalize_spec");
      begin
         F86;
      end;
      declare
         procedure F87;
         pragma Import (Ada, F87, "gdk__display__finalize_spec");
      begin
         F87;
      end;
      declare
         procedure F88;
         pragma Import (Ada, F88, "gdk__frame_clock__finalize_spec");
      begin
         F88;
      end;
      E126 := E126 - 1;
      declare
         procedure F89;
         pragma Import (Ada, F89, "glib__object__finalize_spec");
      begin
         F89;
      end;
      E202 := E202 - 1;
      declare
         procedure F90;
         pragma Import (Ada, F90, "gdk__frame_timings__finalize_spec");
      begin
         F90;
      end;
      E504 := E504 - 1;
      declare
         procedure F91;
         pragma Import (Ada, F91, "datatypes__finalize_spec");
      begin
         F91;
      end;
      E118 := E118 - 1;
      declare
         procedure F92;
         pragma Import (Ada, F92, "glib__finalize_spec");
      begin
         F92;
      end;
      E488 := E488 - 1;
      declare
         procedure F93;
         pragma Import (Ada, F93, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F93;
      end;
      E102 := E102 - 1;
      declare
         procedure F94;
         pragma Import (Ada, F94, "ada__text_io__finalize_spec");
      begin
         F94;
      end;
      declare
         procedure F95;
         pragma Import (Ada, F95, "gnat__sockets__finalize_body");
      begin
         E420 := E420 - 1;
         F95;
      end;
      E044 := E044 - 1;
      declare
         procedure F96;
         pragma Import (Ada, F96, "ada__strings__unbounded__finalize_spec");
      begin
         F96;
      end;
      declare
         procedure F97;
         pragma Import (Ada, F97, "system__file_io__finalize_body");
      begin
         E107 := E107 - 1;
         F97;
      end;
      E075 := E075 - 1;
      E071 := E071 - 1;
      E427 := E427 - 1;
      declare
         procedure F98;
         pragma Import (Ada, F98, "system__pool_size__finalize_spec");
      begin
         F98;
      end;
      declare
         procedure F99;
         pragma Import (Ada, F99, "gnat__sockets__finalize_spec");
      begin
         F99;
      end;
      E122 := E122 - 1;
      declare
         procedure F100;
         pragma Import (Ada, F100, "system__pool_global__finalize_spec");
      begin
         F100;
      end;
      declare
         procedure F101;
         pragma Import (Ada, F101, "system__storage_pools__subpools__finalize_spec");
      begin
         F101;
      end;
      declare
         procedure F102;
         pragma Import (Ada, F102, "system__finalization_masters__finalize_spec");
      begin
         F102;
      end;
      E400 := E400 - 1;
      declare
         procedure F103;
         pragma Import (Ada, F103, "ada__streams__stream_io__finalize_spec");
      begin
         F103;
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
      E008 := E008 + 1;
      Ada.Containers'Elab_Spec;
      E391 := E391 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E084 := E084 + 1;
      Ada.Strings'Elab_Spec;
      E005 := E005 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E442 := E442 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E083 := E083 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E022 := E022 + 1;
      System.File_Control_Block'Elab_Spec;
      E114 := E114 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E400 := E400 + 1;
      System.Finalization_Root'Elab_Spec;
      E086 := E086 + 1;
      Ada.Finalization'Elab_Spec;
      E081 := E081 + 1;
      System.Storage_Pools'Elab_Spec;
      E088 := E088 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Task_Info'Elab_Spec;
      E464 := E464 + 1;
      E508 := E508 + 1;
      E515 := E515 + 1;
      Gnat.Secure_Hashes.Sha2_64'Elab_Spec;
      E510 := E510 + 1;
      System.Assertions'Elab_Spec;
      E385 := E385 + 1;
      System.Pool_Global'Elab_Spec;
      E122 := E122 + 1;
      Gnat.Sockets'Elab_Spec;
      System.Pool_Size'Elab_Spec;
      E427 := E427 + 1;
      E071 := E071 + 1;
      System.Finalization_Masters'Elab_Body;
      E075 := E075 + 1;
      System.File_Io'Elab_Body;
      E107 := E107 + 1;
      E120 := E120 + 1;
      E109 := E109 + 1;
      Ada.Tags'Elab_Body;
      E055 := E055 + 1;
      E048 := E048 + 1;
      System.Soft_Links'Elab_Body;
      E010 := E010 + 1;
      System.Os_Lib'Elab_Body;
      E111 := E111 + 1;
      System.Secondary_Stack'Elab_Body;
      E014 := E014 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E044 := E044 + 1;
      Gnat.Sha512'Elab_Spec;
      E506 := E506 + 1;
      Gnat.Sockets.Thin_Common'Elab_Spec;
      E425 := E425 + 1;
      Gnat.Sockets.Thin'Elab_Body;
      E423 := E423 + 1;
      Gnat.Sockets'Elab_Body;
      E420 := E420 + 1;
      Gnat.String_Split'Elab_Spec;
      E432 := E432 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E398 := E398 + 1;
      System.Tasking.Initialization'Elab_Body;
      E476 := E476 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E500 := E500 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E102 := E102 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E484 := E484 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E488 := E488 + 1;
      System.Tasking.Queuing'Elab_Body;
      E492 := E492 + 1;
      System.Tasking.Stages'Elab_Body;
      E498 := E498 + 1;
      Glib'Elab_Spec;
      E118 := E118 + 1;
      Gtkada.Types'Elab_Spec;
      E143 := E143 + 1;
      Client_Logic'Elab_Spec;
      E096 := E096 + 1;
      E098 := E098 + 1;
      Datatypes'Elab_Spec;
      E504 := E504 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      E202 := E202 + 1;
      E145 := E145 + 1;
      Gdk.Visual'Elab_Spec;
      Gdk.Visual'Elab_Body;
      E174 := E174 + 1;
      E147 := E147 + 1;
      Glib.Object'Elab_Spec;
      E128 := E128 + 1;
      Glib.Values'Elab_Body;
      E139 := E139 + 1;
      E154 := E154 + 1;
      E156 := E156 + 1;
      Gdk.Color'Elab_Spec;
      E161 := E161 + 1;
      Glib.Generic_Properties'Elab_Spec;
      Glib.Generic_Properties'Elab_Body;
      E164 := E164 + 1;
      E141 := E141 + 1;
      Gtkada.Bindings'Elab_Spec;
      E131 := E131 + 1;
      E247 := E247 + 1;
      E137 := E137 + 1;
      E313 := E313 + 1;
      Glib.Object'Elab_Body;
      E126 := E126 + 1;
      Gdk.Rgba'Elab_Body;
      E166 := E166 + 1;
      Gdk.Color'Elab_Body;
      E194 := E194 + 1;
      E291 := E291 + 1;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Types'Elab_Spec;
      E162 := E162 + 1;
      Gdk.Event'Elab_Spec;
      E159 := E159 + 1;
      Gdk.Display'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      E204 := E204 + 1;
      Glib.Properties'Elab_Spec;
      E176 := E176 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E170 := E170 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Device'Elab_Body;
      E196 := E196 + 1;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E198 := E198 + 1;
      Gdk.Window'Elab_Spec;
      E241 := E241 + 1;
      Glib.Variant'Elab_Spec;
      E311 := E311 + 1;
      Glib.Menu_Model'Elab_Spec;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Actionable'Elab_Spec;
      E317 := E317 + 1;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E182 := E182 + 1;
      E180 := E180 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E259 := E259 + 1;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Css_Section'Elab_Spec;
      E275 := E275 + 1;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Enums'Elab_Spec;
      E190 := E190 + 1;
      Gtk.Icon_Source'Elab_Spec;
      E271 := E271 + 1;
      Gtk.Orientable'Elab_Spec;
      E237 := E237 + 1;
      Gtk.Paper_Size'Elab_Spec;
      E293 := E293 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E289 := E289 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E301 := E301 + 1;
      Gtk.Scrollable'Elab_Spec;
      E355 := E355 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E208 := E208 + 1;
      Gtk.Style'Elab_Spec;
      E283 := E283 + 1;
      Gtk.Target_List'Elab_Spec;
      E281 := E281 + 1;
      Gtk.Clipboard'Elab_Spec;
      Gtk.Text_Mark'Elab_Spec;
      Gtk.Text_Mark'Elab_Body;
      E363 := E363 + 1;
      Gtk.Tree_Model'Elab_Spec;
      E329 := E329 + 1;
      E331 := E331 + 1;
      Gtk.List_Store'Elab_Spec;
      Gtk.List_Store'Elab_Body;
      E327 := E327 + 1;
      Gtk.Tree_Store'Elab_Spec;
      Gtk.Tree_Store'Elab_Body;
      E369 := E369 + 1;
      Gtkada.Builder'Elab_Spec;
      Gui_To_Server_Communication'Elab_Spec;
      E516 := E516 + 1;
      Pango.Enums'Elab_Spec;
      E215 := E215 + 1;
      Pango.Attributes'Elab_Spec;
      E233 := E233 + 1;
      Pango.Font_Metrics'Elab_Spec;
      E219 := E219 + 1;
      Pango.Language'Elab_Spec;
      E221 := E221 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E217 := E217 + 1;
      E307 := E307 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E309 := E309 + 1;
      Gtk.Text_Iter'Elab_Spec;
      E305 := E305 + 1;
      Gtk.Text_Tag_Table'Elab_Spec;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E225 := E225 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E223 := E223 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E227 := E227 + 1;
      E229 := E229 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E213 := E213 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E297 := E297 + 1;
      Pango.Tabs'Elab_Spec;
      E235 := E235 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E231 := E231 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E295 := E295 + 1;
      Gtk.Widget'Elab_Spec;
      Gtk.Action'Elab_Spec;
      Gtk.Activatable'Elab_Spec;
      E319 := E319 + 1;
      Gtk.Cell_Renderer'Elab_Spec;
      E261 := E261 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Cell_Renderer_Text'Elab_Spec;
      Gtk.Cell_Renderer_Toggle'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E243 := E243 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E178 := E178 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Frame'Elab_Spec;
      Gtk.Frame'Elab_Body;
      E325 := E325 + 1;
      Gtk.Grange'Elab_Spec;
      E335 := E335 + 1;
      E387 := E387 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E279 := E279 + 1;
      Gtk.Notebook'Elab_Spec;
      Gtk.Scrollbar'Elab_Spec;
      Gtk.Scrollbar'Elab_Body;
      E347 := E347 + 1;
      Gtk.Scrolled_Window'Elab_Spec;
      Gtk.Size_Group'Elab_Spec;
      Gtk.Size_Group'Elab_Body;
      E532 := E532 + 1;
      Gtk.Status_Bar'Elab_Spec;
      E277 := E277 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      E269 := E269 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E267 := E267 + 1;
      Gtk.Gentry'Elab_Spec;
      Gtk.Spin_Button'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Body;
      E361 := E361 + 1;
      Gtk.Text_Buffer'Elab_Spec;
      Gtk.Text_View'Elab_Spec;
      Gtk.Tool_Item'Elab_Spec;
      Gtk.Tool_Button'Elab_Spec;
      Gtk.Tooltip'Elab_Spec;
      Gtk.Tooltip'Elab_Body;
      E373 := E373 + 1;
      Gtk.Tree_Selection'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      Gtk.Arguments'Elab_Spec;
      E152 := E152 + 1;
      Gtk.Print_Operation'Elab_Body;
      E287 := E287 + 1;
      Gtk.Dialog'Elab_Body;
      E168 := E168 + 1;
      Gtk.Window'Elab_Body;
      E239 := E239 + 1;
      Gtk.Tree_View'Elab_Body;
      E371 := E371 + 1;
      Gtk.Tree_View_Column'Elab_Body;
      E375 := E375 + 1;
      Gtk.Tree_Selection'Elab_Body;
      E367 := E367 + 1;
      Gtk.Tool_Button'Elab_Body;
      E528 := E528 + 1;
      Gtk.Tool_Item'Elab_Body;
      E530 := E530 + 1;
      Gtk.Text_View'Elab_Body;
      E353 := E353 + 1;
      Gtk.Text_Buffer'Elab_Body;
      E357 := E357 + 1;
      Gtk.Spin_Button'Elab_Body;
      E351 := E351 + 1;
      Gtk.Gentry'Elab_Body;
      E245 := E245 + 1;
      Gtk.Style_Context'Elab_Body;
      E273 := E273 + 1;
      Gtk.Status_Bar'Elab_Body;
      E303 := E303 + 1;
      Gtk.Scrolled_Window'Elab_Body;
      E345 := E345 + 1;
      Gtk.Notebook'Elab_Body;
      E285 := E285 + 1;
      Gtk.Menu'Elab_Body;
      E337 := E337 + 1;
      Gtk.Menu_Shell'Elab_Body;
      E343 := E343 + 1;
      Gtk.Menu_Item'Elab_Body;
      E341 := E341 + 1;
      Gtk.Grange'Elab_Body;
      E349 := E349 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E255 := E255 + 1;
      Gtk.Button'Elab_Body;
      E150 := E150 + 1;
      Gtk.Container'Elab_Body;
      E186 := E186 + 1;
      Gtk.Cell_Renderer_Toggle'Elab_Body;
      E323 := E323 + 1;
      Gtk.Cell_Renderer_Text'Elab_Body;
      E321 := E321 + 1;
      Gtk.Cell_Area'Elab_Body;
      E257 := E257 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E263 := E263 + 1;
      Gtk.Action'Elab_Body;
      E315 := E315 + 1;
      Gtk.Widget'Elab_Body;
      E192 := E192 + 1;
      E299 := E299 + 1;
      Gtk.Text_Tag_Table'Elab_Body;
      E365 := E365 + 1;
      E333 := E333 + 1;
      E265 := E265 + 1;
      Gtk.Clipboard'Elab_Body;
      E359 := E359 + 1;
      Gtk.Style'Elab_Body;
      E210 := E210 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E253 := E253 + 1;
      E249 := E249 + 1;
      Gtk.Adjustment'Elab_Body;
      E188 := E188 + 1;
      Gtk.Accel_Group'Elab_Body;
      E206 := E206 + 1;
      Glib.Menu_Model'Elab_Body;
      E339 := E339 + 1;
      Gdk.Display'Elab_Body;
      E172 := E172 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E200 := E200 + 1;
      E251 := E251 + 1;
      Gtkada.Handlers'Elab_Spec;
      E388 := E388 + 1;
      Gtkada.Builder'Elab_Body;
      E381 := E381 + 1;
      E404 := E404 + 1;
      User_Databases'Elab_Spec;
      E518 := E518 + 1;
      Server_To_Gui_Communication'Elab_Spec;
      E433 := E433 + 1;
      Concrete_Server_Gui_Logic'Elab_Spec;
      Concrete_Server_Gui_Logic'Elab_Body;
      E116 := E116 + 1;
      E100 := E100 + 1;
      Concrete_Server_Logic'Elab_Spec;
      Concrete_Server_Logic'Elab_Body;
      E446 := E446 + 1;
      Serverguicallbacks'Elab_Body;
      E526 := E526 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

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
   --   C:\Users\Thomas\Documents\adachat\client_logic.o
   --   C:\Users\Thomas\Documents\adachat\client_ui.o
   --   C:\Users\Thomas\Documents\adachat\datatypes.o
   --   C:\Users\Thomas\Documents\adachat\gui_to_server_communication.o
   --   C:\Users\Thomas\Documents\adachat\protocol.o
   --   C:\Users\Thomas\Documents\adachat\main.o
   --   C:\Users\Thomas\Documents\adachat\user_databases.o
   --   C:\Users\Thomas\Documents\adachat\server_to_gui_communication.o
   --   C:\Users\Thomas\Documents\adachat\concrete_server_gui_logic.o
   --   C:\Users\Thomas\Documents\adachat\ServerGuiEntryPoint.o
   --   C:\Users\Thomas\Documents\adachat\concrete_server_logic.o
   --   C:\Users\Thomas\Documents\adachat\ServerGuiCallbacks.o
   --   -LC:\Users\Thomas\Documents\adachat\
   --   -LC:\Users\Thomas\Documents\adachat\
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
