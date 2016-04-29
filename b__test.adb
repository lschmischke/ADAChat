pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__test.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__test.adb");
pragma Suppress (Overflow_Check);
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E072 : Short_Integer; pragma Import (Ada, E072, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E350 : Short_Integer; pragma Import (Ada, E350, "ada__containers_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__io_exceptions_E");
   E354 : Short_Integer; pragma Import (Ada, E354, "ada__strings_E");
   E360 : Short_Integer; pragma Import (Ada, E360, "ada__strings__maps_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__tags_E");
   E058 : Short_Integer; pragma Import (Ada, E058, "ada__streams_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "interfaces__c_E");
   E079 : Short_Integer; pragma Import (Ada, E079, "interfaces__c__strings_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "system__file_control_block_E");
   E377 : Short_Integer; pragma Import (Ada, E377, "ada__streams__stream_io_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "system__file_io_E");
   E068 : Short_Integer; pragma Import (Ada, E068, "system__finalization_root_E");
   E066 : Short_Integer; pragma Import (Ada, E066, "ada__finalization_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "system__storage_pools_E");
   E081 : Short_Integer; pragma Import (Ada, E081, "system__finalization_masters_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "system__storage_pools__subpools_E");
   E304 : Short_Integer; pragma Import (Ada, E304, "system__assertions_E");
   E091 : Short_Integer; pragma Import (Ada, E091, "system__pool_global_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E356 : Short_Integer; pragma Import (Ada, E356, "ada__strings__unbounded_E");
   E375 : Short_Integer; pragma Import (Ada, E375, "system__strings__stream_ops_E");
   E056 : Short_Integer; pragma Import (Ada, E056, "ada__text_io_E");
   E077 : Short_Integer; pragma Import (Ada, E077, "glib_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "gtkada__types_E");
   E177 : Short_Integer; pragma Import (Ada, E177, "gdk__frame_timings_E");
   E122 : Short_Integer; pragma Import (Ada, E122, "glib__glist_E");
   E151 : Short_Integer; pragma Import (Ada, E151, "gdk__visual_E");
   E124 : Short_Integer; pragma Import (Ada, E124, "glib__gslist_E");
   E266 : Short_Integer; pragma Import (Ada, E266, "glib__key_file_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "glib__object_E");
   E288 : Short_Integer; pragma Import (Ada, E288, "glib__string_E");
   E101 : Short_Integer; pragma Import (Ada, E101, "glib__type_conversion_hooks_E");
   E114 : Short_Integer; pragma Import (Ada, E114, "glib__types_E");
   E222 : Short_Integer; pragma Import (Ada, E222, "glib__g_icon_E");
   E116 : Short_Integer; pragma Import (Ada, E116, "glib__values_E");
   E131 : Short_Integer; pragma Import (Ada, E131, "cairo_E");
   E133 : Short_Integer; pragma Import (Ada, E133, "cairo__region_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "gdk__color_E");
   E138 : Short_Integer; pragma Import (Ada, E138, "gdk__rectangle_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "gdk__rgba_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "glib__generic_properties_E");
   E226 : Short_Integer; pragma Import (Ada, E226, "gtk__editable_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "gtkada__c_E");
   E108 : Short_Integer; pragma Import (Ada, E108, "gtkada__bindings_E");
   E175 : Short_Integer; pragma Import (Ada, E175, "gdk__frame_clock_E");
   E139 : Short_Integer; pragma Import (Ada, E139, "gdk__types_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "gdk__event_E");
   E149 : Short_Integer; pragma Import (Ada, E149, "gdk__display_E");
   E179 : Short_Integer; pragma Import (Ada, E179, "gdk__pixbuf_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "glib__properties_E");
   E147 : Short_Integer; pragma Import (Ada, E147, "gdk__screen_E");
   E171 : Short_Integer; pragma Import (Ada, E171, "gdk__device_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "gdk__drag_contexts_E");
   E216 : Short_Integer; pragma Import (Ada, E216, "gdk__window_E");
   E286 : Short_Integer; pragma Import (Ada, E286, "glib__variant_E");
   E387 : Short_Integer; pragma Import (Ada, E387, "glib__menu_model_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "gtk__accel_group_E");
   E292 : Short_Integer; pragma Import (Ada, E292, "gtk__actionable_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "gtk__adjustment_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "gtk__builder_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "gtk__buildable_E");
   E234 : Short_Integer; pragma Import (Ada, E234, "gtk__cell_area_context_E");
   E224 : Short_Integer; pragma Import (Ada, E224, "gtk__cell_editable_E");
   E250 : Short_Integer; pragma Import (Ada, E250, "gtk__css_section_E");
   E228 : Short_Integer; pragma Import (Ada, E228, "gtk__entry_buffer_E");
   E165 : Short_Integer; pragma Import (Ada, E165, "gtk__enums_E");
   E246 : Short_Integer; pragma Import (Ada, E246, "gtk__icon_source_E");
   E212 : Short_Integer; pragma Import (Ada, E212, "gtk__orientable_E");
   E268 : Short_Integer; pragma Import (Ada, E268, "gtk__paper_size_E");
   E264 : Short_Integer; pragma Import (Ada, E264, "gtk__page_setup_E");
   E276 : Short_Integer; pragma Import (Ada, E276, "gtk__print_settings_E");
   E320 : Short_Integer; pragma Import (Ada, E320, "gtk__scrollable_E");
   E183 : Short_Integer; pragma Import (Ada, E183, "gtk__selection_data_E");
   E185 : Short_Integer; pragma Import (Ada, E185, "gtk__style_E");
   E258 : Short_Integer; pragma Import (Ada, E258, "gtk__target_entry_E");
   E256 : Short_Integer; pragma Import (Ada, E256, "gtk__target_list_E");
   E324 : Short_Integer; pragma Import (Ada, E324, "gtk__clipboard_E");
   E328 : Short_Integer; pragma Import (Ada, E328, "gtk__text_mark_E");
   E240 : Short_Integer; pragma Import (Ada, E240, "gtk__tree_model_E");
   E338 : Short_Integer; pragma Import (Ada, E338, "gtk__tree_drag_dest_E");
   E340 : Short_Integer; pragma Import (Ada, E340, "gtk__tree_drag_source_E");
   E334 : Short_Integer; pragma Import (Ada, E334, "gtk__tree_sortable_E");
   E383 : Short_Integer; pragma Import (Ada, E383, "gtk__list_store_E");
   E336 : Short_Integer; pragma Import (Ada, E336, "gtk__tree_store_E");
   E346 : Short_Integer; pragma Import (Ada, E346, "gtkada__builder_E");
   E190 : Short_Integer; pragma Import (Ada, E190, "pango__enums_E");
   E208 : Short_Integer; pragma Import (Ada, E208, "pango__attributes_E");
   E194 : Short_Integer; pragma Import (Ada, E194, "pango__font_metrics_E");
   E196 : Short_Integer; pragma Import (Ada, E196, "pango__language_E");
   E192 : Short_Integer; pragma Import (Ada, E192, "pango__font_E");
   E282 : Short_Integer; pragma Import (Ada, E282, "gtk__text_attributes_E");
   E284 : Short_Integer; pragma Import (Ada, E284, "gtk__text_tag_E");
   E280 : Short_Integer; pragma Import (Ada, E280, "gtk__text_iter_E");
   E330 : Short_Integer; pragma Import (Ada, E330, "gtk__text_tag_table_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "pango__font_face_E");
   E198 : Short_Integer; pragma Import (Ada, E198, "pango__font_family_E");
   E202 : Short_Integer; pragma Import (Ada, E202, "pango__fontset_E");
   E204 : Short_Integer; pragma Import (Ada, E204, "pango__matrix_E");
   E188 : Short_Integer; pragma Import (Ada, E188, "pango__context_E");
   E272 : Short_Integer; pragma Import (Ada, E272, "pango__font_map_E");
   E210 : Short_Integer; pragma Import (Ada, E210, "pango__tabs_E");
   E206 : Short_Integer; pragma Import (Ada, E206, "pango__layout_E");
   E270 : Short_Integer; pragma Import (Ada, E270, "gtk__print_context_E");
   E274 : Short_Integer; pragma Import (Ada, E274, "gtk__print_operation_preview_E");
   E167 : Short_Integer; pragma Import (Ada, E167, "gtk__widget_E");
   E290 : Short_Integer; pragma Import (Ada, E290, "gtk__action_E");
   E294 : Short_Integer; pragma Import (Ada, E294, "gtk__activatable_E");
   E238 : Short_Integer; pragma Import (Ada, E238, "gtk__cell_renderer_E");
   E236 : Short_Integer; pragma Import (Ada, E236, "gtk__cell_layout_E");
   E232 : Short_Integer; pragma Import (Ada, E232, "gtk__cell_area_E");
   E296 : Short_Integer; pragma Import (Ada, E296, "gtk__cell_renderer_text_E");
   E298 : Short_Integer; pragma Import (Ada, E298, "gtk__cell_renderer_toggle_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "gtk__container_E");
   E218 : Short_Integer; pragma Import (Ada, E218, "gtk__bin_E");
   E155 : Short_Integer; pragma Import (Ada, E155, "gtk__box_E");
   E127 : Short_Integer; pragma Import (Ada, E127, "gtk__button_E");
   E230 : Short_Integer; pragma Import (Ada, E230, "gtk__entry_completion_E");
   E300 : Short_Integer; pragma Import (Ada, E300, "gtk__frame_E");
   E316 : Short_Integer; pragma Import (Ada, E316, "gtk__grange_E");
   E310 : Short_Integer; pragma Import (Ada, E310, "gtk__main_E");
   E306 : Short_Integer; pragma Import (Ada, E306, "gtk__marshallers_E");
   E389 : Short_Integer; pragma Import (Ada, E389, "gtk__menu_item_E");
   E391 : Short_Integer; pragma Import (Ada, E391, "gtk__menu_shell_E");
   E385 : Short_Integer; pragma Import (Ada, E385, "gtk__menu_E");
   E254 : Short_Integer; pragma Import (Ada, E254, "gtk__misc_E");
   E260 : Short_Integer; pragma Import (Ada, E260, "gtk__notebook_E");
   E314 : Short_Integer; pragma Import (Ada, E314, "gtk__scrollbar_E");
   E312 : Short_Integer; pragma Import (Ada, E312, "gtk__scrolled_window_E");
   E278 : Short_Integer; pragma Import (Ada, E278, "gtk__status_bar_E");
   E252 : Short_Integer; pragma Import (Ada, E252, "gtk__style_provider_E");
   E248 : Short_Integer; pragma Import (Ada, E248, "gtk__style_context_E");
   E244 : Short_Integer; pragma Import (Ada, E244, "gtk__icon_set_E");
   E242 : Short_Integer; pragma Import (Ada, E242, "gtk__image_E");
   E220 : Short_Integer; pragma Import (Ada, E220, "gtk__gentry_E");
   E393 : Short_Integer; pragma Import (Ada, E393, "gtk__spin_button_E");
   E326 : Short_Integer; pragma Import (Ada, E326, "gtk__text_child_anchor_E");
   E322 : Short_Integer; pragma Import (Ada, E322, "gtk__text_buffer_E");
   E318 : Short_Integer; pragma Import (Ada, E318, "gtk__text_view_E");
   E344 : Short_Integer; pragma Import (Ada, E344, "gtk__tooltip_E");
   E332 : Short_Integer; pragma Import (Ada, E332, "gtk__tree_selection_E");
   E308 : Short_Integer; pragma Import (Ada, E308, "gtk__tree_view_column_E");
   E342 : Short_Integer; pragma Import (Ada, E342, "gtk__tree_view_E");
   E214 : Short_Integer; pragma Import (Ada, E214, "gtk__window_E");
   E145 : Short_Integer; pragma Import (Ada, E145, "gtk__dialog_E");
   E262 : Short_Integer; pragma Import (Ada, E262, "gtk__print_operation_E");
   E129 : Short_Integer; pragma Import (Ada, E129, "gtk__arguments_E");
   E347 : Short_Integer; pragma Import (Ada, E347, "gtkada__handlers_E");
   E381 : Short_Integer; pragma Import (Ada, E381, "serverguicallbacks_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      declare
         procedure F1;
         pragma Import (Ada, F1, "gtkada__builder__finalize_body");
      begin
         E346 := E346 - 1;
         F1;
      end;
      declare
         procedure F2;
         pragma Import (Ada, F2, "gtkada__handlers__finalize_spec");
      begin
         E347 := E347 - 1;
         F2;
      end;
      E175 := E175 - 1;
      E149 := E149 - 1;
      E387 := E387 - 1;
      E181 := E181 - 1;
      E163 := E163 - 1;
      E228 := E228 - 1;
      E185 := E185 - 1;
      E324 := E324 - 1;
      E240 := E240 - 1;
      E330 := E330 - 1;
      E167 := E167 - 1;
      E290 := E290 - 1;
      E238 := E238 - 1;
      E232 := E232 - 1;
      E296 := E296 - 1;
      E298 := E298 - 1;
      E161 := E161 - 1;
      E127 := E127 - 1;
      E230 := E230 - 1;
      E316 := E316 - 1;
      E389 := E389 - 1;
      E391 := E391 - 1;
      E385 := E385 - 1;
      E260 := E260 - 1;
      E312 := E312 - 1;
      E278 := E278 - 1;
      E248 := E248 - 1;
      E220 := E220 - 1;
      E393 := E393 - 1;
      E322 := E322 - 1;
      E318 := E318 - 1;
      E332 := E332 - 1;
      E308 := E308 - 1;
      E342 := E342 - 1;
      E214 := E214 - 1;
      E145 := E145 - 1;
      E262 := E262 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "gtk__print_operation__finalize_spec");
      begin
         F3;
      end;
      declare
         procedure F4;
         pragma Import (Ada, F4, "gtk__dialog__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "gtk__window__finalize_spec");
      begin
         F5;
      end;
      declare
         procedure F6;
         pragma Import (Ada, F6, "gtk__tree_view__finalize_spec");
      begin
         F6;
      end;
      declare
         procedure F7;
         pragma Import (Ada, F7, "gtk__tree_view_column__finalize_spec");
      begin
         F7;
      end;
      declare
         procedure F8;
         pragma Import (Ada, F8, "gtk__tree_selection__finalize_spec");
      begin
         F8;
      end;
      E344 := E344 - 1;
      declare
         procedure F9;
         pragma Import (Ada, F9, "gtk__tooltip__finalize_spec");
      begin
         F9;
      end;
      declare
         procedure F10;
         pragma Import (Ada, F10, "gtk__text_view__finalize_spec");
      begin
         F10;
      end;
      declare
         procedure F11;
         pragma Import (Ada, F11, "gtk__text_buffer__finalize_spec");
      begin
         F11;
      end;
      E326 := E326 - 1;
      declare
         procedure F12;
         pragma Import (Ada, F12, "gtk__text_child_anchor__finalize_spec");
      begin
         F12;
      end;
      declare
         procedure F13;
         pragma Import (Ada, F13, "gtk__spin_button__finalize_spec");
      begin
         F13;
      end;
      declare
         procedure F14;
         pragma Import (Ada, F14, "gtk__gentry__finalize_spec");
      begin
         F14;
      end;
      E242 := E242 - 1;
      declare
         procedure F15;
         pragma Import (Ada, F15, "gtk__image__finalize_spec");
      begin
         F15;
      end;
      E244 := E244 - 1;
      declare
         procedure F16;
         pragma Import (Ada, F16, "gtk__icon_set__finalize_spec");
      begin
         F16;
      end;
      declare
         procedure F17;
         pragma Import (Ada, F17, "gtk__style_context__finalize_spec");
      begin
         F17;
      end;
      declare
         procedure F18;
         pragma Import (Ada, F18, "gtk__status_bar__finalize_spec");
      begin
         F18;
      end;
      declare
         procedure F19;
         pragma Import (Ada, F19, "gtk__scrolled_window__finalize_spec");
      begin
         F19;
      end;
      E314 := E314 - 1;
      declare
         procedure F20;
         pragma Import (Ada, F20, "gtk__scrollbar__finalize_spec");
      begin
         F20;
      end;
      declare
         procedure F21;
         pragma Import (Ada, F21, "gtk__notebook__finalize_spec");
      begin
         F21;
      end;
      E254 := E254 - 1;
      declare
         procedure F22;
         pragma Import (Ada, F22, "gtk__misc__finalize_spec");
      begin
         F22;
      end;
      declare
         procedure F23;
         pragma Import (Ada, F23, "gtk__menu__finalize_spec");
      begin
         F23;
      end;
      declare
         procedure F24;
         pragma Import (Ada, F24, "gtk__menu_shell__finalize_spec");
      begin
         F24;
      end;
      declare
         procedure F25;
         pragma Import (Ada, F25, "gtk__menu_item__finalize_spec");
      begin
         F25;
      end;
      declare
         procedure F26;
         pragma Import (Ada, F26, "gtk__grange__finalize_spec");
      begin
         F26;
      end;
      E300 := E300 - 1;
      declare
         procedure F27;
         pragma Import (Ada, F27, "gtk__frame__finalize_spec");
      begin
         F27;
      end;
      declare
         procedure F28;
         pragma Import (Ada, F28, "gtk__entry_completion__finalize_spec");
      begin
         F28;
      end;
      declare
         procedure F29;
         pragma Import (Ada, F29, "gtk__button__finalize_spec");
      begin
         F29;
      end;
      E155 := E155 - 1;
      declare
         procedure F30;
         pragma Import (Ada, F30, "gtk__box__finalize_spec");
      begin
         F30;
      end;
      E218 := E218 - 1;
      declare
         procedure F31;
         pragma Import (Ada, F31, "gtk__bin__finalize_spec");
      begin
         F31;
      end;
      declare
         procedure F32;
         pragma Import (Ada, F32, "gtk__container__finalize_spec");
      begin
         F32;
      end;
      declare
         procedure F33;
         pragma Import (Ada, F33, "gtk__cell_renderer_toggle__finalize_spec");
      begin
         F33;
      end;
      declare
         procedure F34;
         pragma Import (Ada, F34, "gtk__cell_renderer_text__finalize_spec");
      begin
         F34;
      end;
      declare
         procedure F35;
         pragma Import (Ada, F35, "gtk__cell_area__finalize_spec");
      begin
         F35;
      end;
      declare
         procedure F36;
         pragma Import (Ada, F36, "gtk__cell_renderer__finalize_spec");
      begin
         F36;
      end;
      declare
         procedure F37;
         pragma Import (Ada, F37, "gtk__action__finalize_spec");
      begin
         F37;
      end;
      declare
         procedure F38;
         pragma Import (Ada, F38, "gtk__widget__finalize_spec");
      begin
         F38;
      end;
      E270 := E270 - 1;
      declare
         procedure F39;
         pragma Import (Ada, F39, "gtk__print_context__finalize_spec");
      begin
         F39;
      end;
      E206 := E206 - 1;
      declare
         procedure F40;
         pragma Import (Ada, F40, "pango__layout__finalize_spec");
      begin
         F40;
      end;
      E210 := E210 - 1;
      declare
         procedure F41;
         pragma Import (Ada, F41, "pango__tabs__finalize_spec");
      begin
         F41;
      end;
      E272 := E272 - 1;
      declare
         procedure F42;
         pragma Import (Ada, F42, "pango__font_map__finalize_spec");
      begin
         F42;
      end;
      E188 := E188 - 1;
      declare
         procedure F43;
         pragma Import (Ada, F43, "pango__context__finalize_spec");
      begin
         F43;
      end;
      E202 := E202 - 1;
      declare
         procedure F44;
         pragma Import (Ada, F44, "pango__fontset__finalize_spec");
      begin
         F44;
      end;
      E198 := E198 - 1;
      declare
         procedure F45;
         pragma Import (Ada, F45, "pango__font_family__finalize_spec");
      begin
         F45;
      end;
      E200 := E200 - 1;
      declare
         procedure F46;
         pragma Import (Ada, F46, "pango__font_face__finalize_spec");
      begin
         F46;
      end;
      declare
         procedure F47;
         pragma Import (Ada, F47, "gtk__text_tag_table__finalize_spec");
      begin
         F47;
      end;
      E284 := E284 - 1;
      declare
         procedure F48;
         pragma Import (Ada, F48, "gtk__text_tag__finalize_spec");
      begin
         F48;
      end;
      E192 := E192 - 1;
      declare
         procedure F49;
         pragma Import (Ada, F49, "pango__font__finalize_spec");
      begin
         F49;
      end;
      E196 := E196 - 1;
      declare
         procedure F50;
         pragma Import (Ada, F50, "pango__language__finalize_spec");
      begin
         F50;
      end;
      E194 := E194 - 1;
      declare
         procedure F51;
         pragma Import (Ada, F51, "pango__font_metrics__finalize_spec");
      begin
         F51;
      end;
      E208 := E208 - 1;
      declare
         procedure F52;
         pragma Import (Ada, F52, "pango__attributes__finalize_spec");
      begin
         F52;
      end;
      declare
         procedure F53;
         pragma Import (Ada, F53, "gtkada__builder__finalize_spec");
      begin
         F53;
      end;
      E336 := E336 - 1;
      declare
         procedure F54;
         pragma Import (Ada, F54, "gtk__tree_store__finalize_spec");
      begin
         F54;
      end;
      E383 := E383 - 1;
      declare
         procedure F55;
         pragma Import (Ada, F55, "gtk__list_store__finalize_spec");
      begin
         F55;
      end;
      declare
         procedure F56;
         pragma Import (Ada, F56, "gtk__tree_model__finalize_spec");
      begin
         F56;
      end;
      E328 := E328 - 1;
      declare
         procedure F57;
         pragma Import (Ada, F57, "gtk__text_mark__finalize_spec");
      begin
         F57;
      end;
      declare
         procedure F58;
         pragma Import (Ada, F58, "gtk__clipboard__finalize_spec");
      begin
         F58;
      end;
      E256 := E256 - 1;
      declare
         procedure F59;
         pragma Import (Ada, F59, "gtk__target_list__finalize_spec");
      begin
         F59;
      end;
      declare
         procedure F60;
         pragma Import (Ada, F60, "gtk__style__finalize_spec");
      begin
         F60;
      end;
      E183 := E183 - 1;
      declare
         procedure F61;
         pragma Import (Ada, F61, "gtk__selection_data__finalize_spec");
      begin
         F61;
      end;
      E276 := E276 - 1;
      declare
         procedure F62;
         pragma Import (Ada, F62, "gtk__print_settings__finalize_spec");
      begin
         F62;
      end;
      E264 := E264 - 1;
      declare
         procedure F63;
         pragma Import (Ada, F63, "gtk__page_setup__finalize_spec");
      begin
         F63;
      end;
      E268 := E268 - 1;
      declare
         procedure F64;
         pragma Import (Ada, F64, "gtk__paper_size__finalize_spec");
      begin
         F64;
      end;
      E246 := E246 - 1;
      declare
         procedure F65;
         pragma Import (Ada, F65, "gtk__icon_source__finalize_spec");
      begin
         F65;
      end;
      declare
         procedure F66;
         pragma Import (Ada, F66, "gtk__entry_buffer__finalize_spec");
      begin
         F66;
      end;
      E250 := E250 - 1;
      declare
         procedure F67;
         pragma Import (Ada, F67, "gtk__css_section__finalize_spec");
      begin
         F67;
      end;
      E234 := E234 - 1;
      declare
         procedure F68;
         pragma Import (Ada, F68, "gtk__cell_area_context__finalize_spec");
      begin
         F68;
      end;
      E159 := E159 - 1;
      declare
         procedure F69;
         pragma Import (Ada, F69, "gtk__builder__finalize_spec");
      begin
         F69;
      end;
      declare
         procedure F70;
         pragma Import (Ada, F70, "gtk__adjustment__finalize_spec");
      begin
         F70;
      end;
      declare
         procedure F71;
         pragma Import (Ada, F71, "gtk__accel_group__finalize_spec");
      begin
         F71;
      end;
      declare
         procedure F72;
         pragma Import (Ada, F72, "glib__menu_model__finalize_spec");
      begin
         F72;
      end;
      E286 := E286 - 1;
      declare
         procedure F73;
         pragma Import (Ada, F73, "glib__variant__finalize_spec");
      begin
         F73;
      end;
      E173 := E173 - 1;
      declare
         procedure F74;
         pragma Import (Ada, F74, "gdk__drag_contexts__finalize_spec");
      begin
         F74;
      end;
      E171 := E171 - 1;
      declare
         procedure F75;
         pragma Import (Ada, F75, "gdk__device__finalize_spec");
      begin
         F75;
      end;
      E147 := E147 - 1;
      declare
         procedure F76;
         pragma Import (Ada, F76, "gdk__screen__finalize_spec");
      begin
         F76;
      end;
      E179 := E179 - 1;
      declare
         procedure F77;
         pragma Import (Ada, F77, "gdk__pixbuf__finalize_spec");
      begin
         F77;
      end;
      declare
         procedure F78;
         pragma Import (Ada, F78, "gdk__display__finalize_spec");
      begin
         F78;
      end;
      declare
         procedure F79;
         pragma Import (Ada, F79, "gdk__frame_clock__finalize_spec");
      begin
         F79;
      end;
      E099 := E099 - 1;
      declare
         procedure F80;
         pragma Import (Ada, F80, "glib__object__finalize_spec");
      begin
         F80;
      end;
      E177 := E177 - 1;
      declare
         procedure F81;
         pragma Import (Ada, F81, "gdk__frame_timings__finalize_spec");
      begin
         F81;
      end;
      E077 := E077 - 1;
      declare
         procedure F82;
         pragma Import (Ada, F82, "glib__finalize_spec");
      begin
         F82;
      end;
      E056 := E056 - 1;
      declare
         procedure F83;
         pragma Import (Ada, F83, "ada__text_io__finalize_spec");
      begin
         F83;
      end;
      E356 := E356 - 1;
      declare
         procedure F84;
         pragma Import (Ada, F84, "ada__strings__unbounded__finalize_spec");
      begin
         F84;
      end;
      declare
         procedure F85;
         pragma Import (Ada, F85, "system__file_io__finalize_body");
      begin
         E064 := E064 - 1;
         F85;
      end;
      E081 := E081 - 1;
      E103 := E103 - 1;
      E091 := E091 - 1;
      declare
         procedure F86;
         pragma Import (Ada, F86, "system__pool_global__finalize_spec");
      begin
         F86;
      end;
      declare
         procedure F87;
         pragma Import (Ada, F87, "system__storage_pools__subpools__finalize_spec");
      begin
         F87;
      end;
      declare
         procedure F88;
         pragma Import (Ada, F88, "system__finalization_masters__finalize_spec");
      begin
         F88;
      end;
      E377 := E377 - 1;
      declare
         procedure F89;
         pragma Import (Ada, F89, "ada__streams__stream_io__finalize_spec");
      begin
         F89;
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
      E023 := E023 + 1;
      Ada.Containers'Elab_Spec;
      E350 := E350 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E059 := E059 + 1;
      Ada.Strings'Elab_Spec;
      E354 := E354 + 1;
      Ada.Strings.Maps'Elab_Spec;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E058 := E058 + 1;
      Interfaces.C'Elab_Spec;
      Interfaces.C.Strings'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.File_Control_Block'Elab_Spec;
      E075 := E075 + 1;
      Ada.Streams.Stream_Io'Elab_Spec;
      E377 := E377 + 1;
      System.Finalization_Root'Elab_Spec;
      E068 := E068 + 1;
      Ada.Finalization'Elab_Spec;
      E066 := E066 + 1;
      System.Storage_Pools'Elab_Spec;
      E089 := E089 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Assertions'Elab_Spec;
      E304 := E304 + 1;
      System.Pool_Global'Elab_Spec;
      E091 := E091 + 1;
      E103 := E103 + 1;
      System.Finalization_Masters'Elab_Body;
      E081 := E081 + 1;
      System.File_Io'Elab_Body;
      E064 := E064 + 1;
      E079 := E079 + 1;
      E070 := E070 + 1;
      Ada.Tags'Elab_Body;
      E006 := E006 + 1;
      E360 := E360 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Os_Lib'Elab_Body;
      E072 := E072 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      Ada.Strings.Unbounded'Elab_Spec;
      E356 := E356 + 1;
      System.Strings.Stream_Ops'Elab_Body;
      E375 := E375 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E056 := E056 + 1;
      Glib'Elab_Spec;
      E077 := E077 + 1;
      Gtkada.Types'Elab_Spec;
      E120 := E120 + 1;
      Gdk.Frame_Timings'Elab_Spec;
      E177 := E177 + 1;
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
      E222 := E222 + 1;
      E114 := E114 + 1;
      E288 := E288 + 1;
      Glib.Object'Elab_Body;
      E099 := E099 + 1;
      Gdk.Rgba'Elab_Body;
      E143 := E143 + 1;
      Gdk.Color'Elab_Body;
      E169 := E169 + 1;
      E266 := E266 + 1;
      Gdk.Frame_Clock'Elab_Spec;
      Gdk.Types'Elab_Spec;
      E139 := E139 + 1;
      Gdk.Event'Elab_Spec;
      E136 := E136 + 1;
      Gdk.Display'Elab_Spec;
      Gdk.Pixbuf'Elab_Spec;
      E179 := E179 + 1;
      Glib.Properties'Elab_Spec;
      E153 := E153 + 1;
      Gdk.Screen'Elab_Spec;
      Gdk.Screen'Elab_Body;
      E147 := E147 + 1;
      Gdk.Device'Elab_Spec;
      Gdk.Device'Elab_Body;
      E171 := E171 + 1;
      Gdk.Drag_Contexts'Elab_Spec;
      Gdk.Drag_Contexts'Elab_Body;
      E173 := E173 + 1;
      Gdk.Window'Elab_Spec;
      E216 := E216 + 1;
      Glib.Variant'Elab_Spec;
      E286 := E286 + 1;
      Glib.Menu_Model'Elab_Spec;
      Gtk.Accel_Group'Elab_Spec;
      Gtk.Actionable'Elab_Spec;
      E292 := E292 + 1;
      Gtk.Adjustment'Elab_Spec;
      Gtk.Builder'Elab_Spec;
      Gtk.Builder'Elab_Body;
      E159 := E159 + 1;
      E157 := E157 + 1;
      Gtk.Cell_Area_Context'Elab_Spec;
      Gtk.Cell_Area_Context'Elab_Body;
      E234 := E234 + 1;
      Gtk.Cell_Editable'Elab_Spec;
      Gtk.Css_Section'Elab_Spec;
      E250 := E250 + 1;
      Gtk.Entry_Buffer'Elab_Spec;
      Gtk.Enums'Elab_Spec;
      E165 := E165 + 1;
      Gtk.Icon_Source'Elab_Spec;
      E246 := E246 + 1;
      Gtk.Orientable'Elab_Spec;
      E212 := E212 + 1;
      Gtk.Paper_Size'Elab_Spec;
      E268 := E268 + 1;
      Gtk.Page_Setup'Elab_Spec;
      Gtk.Page_Setup'Elab_Body;
      E264 := E264 + 1;
      Gtk.Print_Settings'Elab_Spec;
      Gtk.Print_Settings'Elab_Body;
      E276 := E276 + 1;
      Gtk.Scrollable'Elab_Spec;
      E320 := E320 + 1;
      Gtk.Selection_Data'Elab_Spec;
      Gtk.Selection_Data'Elab_Body;
      E183 := E183 + 1;
      Gtk.Style'Elab_Spec;
      E258 := E258 + 1;
      Gtk.Target_List'Elab_Spec;
      E256 := E256 + 1;
      Gtk.Clipboard'Elab_Spec;
      Gtk.Text_Mark'Elab_Spec;
      Gtk.Text_Mark'Elab_Body;
      E328 := E328 + 1;
      Gtk.Tree_Model'Elab_Spec;
      E338 := E338 + 1;
      E340 := E340 + 1;
      Gtk.List_Store'Elab_Spec;
      Gtk.List_Store'Elab_Body;
      E383 := E383 + 1;
      Gtk.Tree_Store'Elab_Spec;
      Gtk.Tree_Store'Elab_Body;
      E336 := E336 + 1;
      Gtkada.Builder'Elab_Spec;
      Pango.Enums'Elab_Spec;
      E190 := E190 + 1;
      Pango.Attributes'Elab_Spec;
      E208 := E208 + 1;
      Pango.Font_Metrics'Elab_Spec;
      E194 := E194 + 1;
      Pango.Language'Elab_Spec;
      E196 := E196 + 1;
      Pango.Font'Elab_Spec;
      Pango.Font'Elab_Body;
      E192 := E192 + 1;
      E282 := E282 + 1;
      Gtk.Text_Tag'Elab_Spec;
      Gtk.Text_Tag'Elab_Body;
      E284 := E284 + 1;
      Gtk.Text_Iter'Elab_Spec;
      E280 := E280 + 1;
      Gtk.Text_Tag_Table'Elab_Spec;
      Pango.Font_Face'Elab_Spec;
      Pango.Font_Face'Elab_Body;
      E200 := E200 + 1;
      Pango.Font_Family'Elab_Spec;
      Pango.Font_Family'Elab_Body;
      E198 := E198 + 1;
      Pango.Fontset'Elab_Spec;
      Pango.Fontset'Elab_Body;
      E202 := E202 + 1;
      E204 := E204 + 1;
      Pango.Context'Elab_Spec;
      Pango.Context'Elab_Body;
      E188 := E188 + 1;
      Pango.Font_Map'Elab_Spec;
      Pango.Font_Map'Elab_Body;
      E272 := E272 + 1;
      Pango.Tabs'Elab_Spec;
      E210 := E210 + 1;
      Pango.Layout'Elab_Spec;
      Pango.Layout'Elab_Body;
      E206 := E206 + 1;
      Gtk.Print_Context'Elab_Spec;
      Gtk.Print_Context'Elab_Body;
      E270 := E270 + 1;
      Gtk.Widget'Elab_Spec;
      Gtk.Action'Elab_Spec;
      Gtk.Activatable'Elab_Spec;
      E294 := E294 + 1;
      Gtk.Cell_Renderer'Elab_Spec;
      E236 := E236 + 1;
      Gtk.Cell_Area'Elab_Spec;
      Gtk.Cell_Renderer_Text'Elab_Spec;
      Gtk.Cell_Renderer_Toggle'Elab_Spec;
      Gtk.Container'Elab_Spec;
      Gtk.Bin'Elab_Spec;
      Gtk.Bin'Elab_Body;
      E218 := E218 + 1;
      Gtk.Box'Elab_Spec;
      Gtk.Box'Elab_Body;
      E155 := E155 + 1;
      Gtk.Button'Elab_Spec;
      Gtk.Entry_Completion'Elab_Spec;
      Gtk.Frame'Elab_Spec;
      Gtk.Frame'Elab_Body;
      E300 := E300 + 1;
      Gtk.Grange'Elab_Spec;
      E310 := E310 + 1;
      E306 := E306 + 1;
      Gtk.Menu_Item'Elab_Spec;
      Gtk.Menu_Shell'Elab_Spec;
      Gtk.Menu'Elab_Spec;
      Gtk.Misc'Elab_Spec;
      Gtk.Misc'Elab_Body;
      E254 := E254 + 1;
      Gtk.Notebook'Elab_Spec;
      Gtk.Scrollbar'Elab_Spec;
      Gtk.Scrollbar'Elab_Body;
      E314 := E314 + 1;
      Gtk.Scrolled_Window'Elab_Spec;
      Gtk.Status_Bar'Elab_Spec;
      E252 := E252 + 1;
      Gtk.Style_Context'Elab_Spec;
      Gtk.Icon_Set'Elab_Spec;
      E244 := E244 + 1;
      Gtk.Image'Elab_Spec;
      Gtk.Image'Elab_Body;
      E242 := E242 + 1;
      Gtk.Gentry'Elab_Spec;
      Gtk.Spin_Button'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Spec;
      Gtk.Text_Child_Anchor'Elab_Body;
      E326 := E326 + 1;
      Gtk.Text_Buffer'Elab_Spec;
      Gtk.Text_View'Elab_Spec;
      Gtk.Tooltip'Elab_Spec;
      Gtk.Tooltip'Elab_Body;
      E344 := E344 + 1;
      Gtk.Tree_Selection'Elab_Spec;
      Gtk.Tree_View_Column'Elab_Spec;
      Gtk.Tree_View'Elab_Spec;
      Gtk.Window'Elab_Spec;
      Gtk.Dialog'Elab_Spec;
      Gtk.Print_Operation'Elab_Spec;
      Gtk.Arguments'Elab_Spec;
      E129 := E129 + 1;
      Gtk.Print_Operation'Elab_Body;
      E262 := E262 + 1;
      Gtk.Dialog'Elab_Body;
      E145 := E145 + 1;
      Gtk.Window'Elab_Body;
      E214 := E214 + 1;
      Gtk.Tree_View'Elab_Body;
      E342 := E342 + 1;
      Gtk.Tree_View_Column'Elab_Body;
      E308 := E308 + 1;
      Gtk.Tree_Selection'Elab_Body;
      E332 := E332 + 1;
      Gtk.Text_View'Elab_Body;
      E318 := E318 + 1;
      Gtk.Text_Buffer'Elab_Body;
      E322 := E322 + 1;
      Gtk.Spin_Button'Elab_Body;
      E393 := E393 + 1;
      Gtk.Gentry'Elab_Body;
      E220 := E220 + 1;
      Gtk.Style_Context'Elab_Body;
      E248 := E248 + 1;
      Gtk.Status_Bar'Elab_Body;
      E278 := E278 + 1;
      Gtk.Scrolled_Window'Elab_Body;
      E312 := E312 + 1;
      Gtk.Notebook'Elab_Body;
      E260 := E260 + 1;
      Gtk.Menu'Elab_Body;
      E385 := E385 + 1;
      Gtk.Menu_Shell'Elab_Body;
      E391 := E391 + 1;
      Gtk.Menu_Item'Elab_Body;
      E389 := E389 + 1;
      Gtk.Grange'Elab_Body;
      E316 := E316 + 1;
      Gtk.Entry_Completion'Elab_Body;
      E230 := E230 + 1;
      Gtk.Button'Elab_Body;
      E127 := E127 + 1;
      Gtk.Container'Elab_Body;
      E161 := E161 + 1;
      Gtk.Cell_Renderer_Toggle'Elab_Body;
      E298 := E298 + 1;
      Gtk.Cell_Renderer_Text'Elab_Body;
      E296 := E296 + 1;
      Gtk.Cell_Area'Elab_Body;
      E232 := E232 + 1;
      Gtk.Cell_Renderer'Elab_Body;
      E238 := E238 + 1;
      Gtk.Action'Elab_Body;
      E290 := E290 + 1;
      Gtk.Widget'Elab_Body;
      E167 := E167 + 1;
      E274 := E274 + 1;
      Gtk.Text_Tag_Table'Elab_Body;
      E330 := E330 + 1;
      E334 := E334 + 1;
      E240 := E240 + 1;
      Gtk.Clipboard'Elab_Body;
      E324 := E324 + 1;
      Gtk.Style'Elab_Body;
      E185 := E185 + 1;
      Gtk.Entry_Buffer'Elab_Body;
      E228 := E228 + 1;
      E224 := E224 + 1;
      Gtk.Adjustment'Elab_Body;
      E163 := E163 + 1;
      Gtk.Accel_Group'Elab_Body;
      E181 := E181 + 1;
      Glib.Menu_Model'Elab_Body;
      E387 := E387 + 1;
      Gdk.Display'Elab_Body;
      E149 := E149 + 1;
      Gdk.Frame_Clock'Elab_Body;
      E175 := E175 + 1;
      E226 := E226 + 1;
      Gtkada.Handlers'Elab_Spec;
      E347 := E347 + 1;
      Gtkada.Builder'Elab_Body;
      E346 := E346 + 1;
      Serverguicallbacks'Elab_Body;
      E381 := E381 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_test");

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
   --   C:\Users\Thomas\Documents\adachat\ServerGuiCallbacks.o
   --   C:\Users\Thomas\Documents\adachat\test.o
   --   -LC:\Users\Thomas\Documents\adachat\
   --   -LC:\Users\Thomas\Documents\adachat\
   --   -LC:\GtkAda\lib\gtkada\static\
   --   -LC:/gnat/2015/lib/gcc/i686-pc-mingw32/4.9.3/adalib/
   --   -static
   --   -shared-libgcc
   --   -shared-libgcc
   --   -shared-libgcc
   --   -lgnat
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
