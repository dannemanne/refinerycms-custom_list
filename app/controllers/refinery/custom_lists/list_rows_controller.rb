module Refinery
  module CustomLists
    class ListRowsController < ::ApplicationController
      before_filter :find_custom_list
      before_filter :find_list_row,   only: [:edit, :update, :destroy]
      before_filter :find_page

      def create
        @list_row_creator = ListRowCreator.new({ custom_list: @custom_list }.reverse_merge(params[:list_row_creator]))
        @list_row_creator.save
        redirect_to "/#{ @page.url[:path].join('/') }"
      end

      def edit
        @list_row_updater = ::Refinery::CustomLists::ListRowUpdater.new({ list_row: @list_row })
      end

      def update
        @list_row_updater = ListRowUpdater.new({ list_row: @list_row }.reverse_merge(params[:list_row_updater]))
        @list_row_updater.save
        redirect_to "/#{ @page.url[:path].join('/') }"
      end

      def destroy

      end

    protected
      def find_custom_list
        @custom_list = CustomList.find(params[:custom_list_id])
      end

      def find_list_row
        @list_row = @custom_list.list_rows.find(params[:id])
      end

      def find_page
        if params[:originating_page_id]
          @page = ::Refinery::Page.find(params[:originating_page_id])
        else
          @page = ::Refinery::Page.first
        end
      end

    end
  end
end
