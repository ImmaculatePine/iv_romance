defmodule IvRomanceWeb.Admin.UploadController do
  use IvRomanceWeb, :controller

  alias IvRomance.Uploads

  def index(conn, _params) do
    uploads = Uploads.list_uploads()
    render(conn, "index.html", uploads: uploads)
  end

  def create(conn, %{"upload" => %{"file" => %Plug.Upload{filename: file_name, path: file_path}}}) do
    case Uploads.create_upload(file_name, file_path) do
      {:ok, _upload} ->
        conn
        |> put_flash(:info, "File uploaded successfully.")
        |> redirect(to: admin_upload_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Failed to upload file.")
        |> redirect(to: admin_upload_path(conn, :index))
    end
  end

  def delete(conn, %{"id" => id}) do
    :ok = Uploads.delete_upload(id)

    conn
    |> put_flash(:info, "Upload deleted successfully.")
    |> redirect(to: admin_upload_path(conn, :index))
  end
end
